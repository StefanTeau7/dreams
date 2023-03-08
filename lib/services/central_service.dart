import 'package:dream_catcher/models/chat.dart';
import 'package:dream_catcher/models/chatRoleType.dart';
import 'package:dream_catcher/services/api_service.dart';
import 'package:flutter/material.dart';

class CentralService extends ChangeNotifier {
  String _currentDreamId = '';

  String get currentDreamId {
    return _currentDreamId;
  }

  set currentDreamId(String id) {
    _currentDreamId = id;
    notifyListeners();
  }

  handleMessageSend(String text) async {
    addUserMessage(dreamID: _currentDreamId, text: text);

    List<Chat>? list = getChatListById(_currentDreamId);

    if (list != null) {
      List<Chat>? newMessage = await ApiService.sendMessage(
        dreamId: _currentDreamId,
        list: list,
      );
      if (newMessage.isNotEmpty) {
        // TODO - verify this is the assistant message
        addAssistantMessage(dreamID: _currentDreamId, text: newMessage.last.text!);
      }
    }
  }
  
  Map<String, List<Chat>> chatsByDreamId = {};

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
