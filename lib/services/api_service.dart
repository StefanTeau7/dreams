import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
  static Future<List<Chat>> sendMessage({required String message, required String modelId}) async {
    try {
      String fixedMessage = message.trim();
      log("modelId $modelId");
      String baseUrl = dotenv.env['BASE_URL']!;
      String apiKey = dotenv.env['API_KEY']!;
      var response = await http.post(
        Uri.parse("$baseUrl/chat/completions"),
        headers: {'Authorization': 'Bearer $apiKey', "Content-Type": "application/json"},
        body: jsonEncode(
          {
            "model": modelId,
            "messages": [
              {
                "role": "system",
                "content":
                    "You are a dream analysis assistant. Ask any questions that might help you analyze the following dream then analyze it."
              },
              {"role": "user", "content": fixedMessage}
            ]
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<Chat> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => Chat(
            msg: jsonResponse["choices"][index]["message"]["content"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
