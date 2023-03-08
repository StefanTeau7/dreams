import 'package:dream_catcher/models/chat.dart';
import 'package:dream_catcher/models/chatRoleType.dart';
import 'package:flutter/cupertino.dart';

class ChatService with ChangeNotifier {
  Map<String, List<Chat>> chatsByDreamId = {};
  // List<Chat> chatList = [];
  // List<Chat> get getChatList {
  //   return chatList;
  // }

  List<Chat>? getChatListById(String? id) {
    if (id == null) return null;
    return chatsByDreamId[id];
  }

  void addUserMessage({required String dreamID, required String text}) {
    List<Chat>? list = getChatListById(dreamID);
    if (list == null || list.isEmpty) {
      list = [Chat(dreamID: dreamID, role: ChatRoleType.USER, text: text, chatIndex: 1)];
    } else {
      int lastIndex = list.last.chatIndex!;
      list.add(Chat(dreamID: dreamID, role: ChatRoleType.USER, text: text, chatIndex: lastIndex + 1));
    }
    notifyListeners();
  }

  void addAssistantMessage({required String dreamID, required String text}) {
    List<Chat>? list = getChatListById(dreamID);
    if (list == null) return;
    int lastIndex = list.last.chatIndex!;
    list.add(Chat(dreamID: dreamID, role: ChatRoleType.ASSISTANT, text: text, chatIndex: lastIndex + 1));
  }
}
