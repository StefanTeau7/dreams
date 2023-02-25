import 'package:dream_catcher/models/chat.dart';
import 'package:dream_catcher/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class ChatService with ChangeNotifier {
  List<Chat> chatList = [];
  List<Chat> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(Chat(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers({required String msg, required String chosenModelId}) async {
    chatList.addAll(await ApiService.sendMessage(
      message: msg,
      modelId: chosenModelId,
    ));
    notifyListeners();
  }
}
