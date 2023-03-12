import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dream_catcher/main.dart';
import 'package:dream_catcher/models/chat.dart';
import 'package:dream_catcher/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Model>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("${dotenv.env['BASE_URL']}/models"),
        headers: {'Authorization': 'Bearer ${dotenv.env['API_KEY']}'},
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      // print("jsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        // log("temp ${value["id"]}");
      }
      return Model.modelsFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // Send Message fct
  static Future<String?> sendMessage({required List<Chat> list}) async {
    try {
      var chatJson = {"model": AI_MODEL_ID};
      var messages = [];
      final instruction = {
        "role": "system",
        "content":
            "You are a dream analysis assistant. Ask any questions that might help you analyze the following dream then analyze it."
      };
      messages.add(instruction);

      for (Chat c in list) {
        final chat = {"role": c.role, "content": c.text};
        messages.add(chat);
      }
      chatJson["messages"] = messages.toString();

      String body = jsonEncode(chatJson);
      String baseUrl = dotenv.env['BASE_URL']!;
      String apiKey = dotenv.env['API_KEY']!;
      var response = await http.post(
        Uri.parse("$baseUrl/chat/completions"),
        headers: {'Authorization': 'Bearer $apiKey', "Content-Type": "application/json"},
        body: body,
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      int lastIndex = jsonResponse["choices"].length - 1;
      return jsonResponse["choices"][lastIndex]["message"]["content"];
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
