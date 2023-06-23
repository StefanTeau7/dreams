import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dream_catcher/main.dart';
import 'package:dream_catcher/models/Chat.dart';
import 'package:dream_catcher/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {

  // Send Message fct
  static Future<String?> sendMessage({required List<Chat> list}) async {
    try {
      var messages = [];
      final instruction = {
        "role": "system",
        "content":
            "You are a dream analysis assistant. Ask any questions that might help you analyze the following dream then analyze it."
      };
      messages.add(instruction);

      for (Chat c in list) {
        String role = c.role.toString().split('.').last.toLowerCase();
        final chat = {"role": role, "content": c.text};
        messages.add(chat);
      }
      var chatJson = {
        "model": AI_MODEL_ID,
        "messages": messages,
        "max_tokens": 3000,
      };
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
      String answer = jsonResponse["choices"][0]["message"]["content"];
      return answer;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
