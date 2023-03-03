import 'package:dream_catcher/models/chat.dart';
import 'package:flutter/cupertino.dart';

class ChatService with ChangeNotifier {
  Map<String, List<Chat>> chatsById = {};
  // List<Chat> chatList = [];
  // List<Chat> get getChatList {
  //   return chatList;
  // }

  List<Chat>? getChatListById(String id) {
    return chatsById[id];
  }

  void addUserMessage({required String id, required String text}) {
    List<Chat>? list = getChatListById(id);
    if (list == null) {
      // create list
    } else {
      int lastIndex = list.last.chatIndex;
      list.add(Chat(role: ChatRoleType.USER, text: text, chatIndex: lastIndex + 1));
    }

    notifyListeners();
  }
}
