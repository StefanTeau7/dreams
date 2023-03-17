import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/models/Chat.dart';
import 'package:dream_catcher/models/ChatRoleType.dart';
import 'package:dream_catcher/services/user_service.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final UserService _userService = getIt<UserService>();
  final Map<String, List<Chat>> _chatsByDreamId = {};

  List<Chat>? getChatListById(String? id) {
    if (id == null) return null;
    return _chatsByDreamId[id];
  }

  Future<List<Chat?>?> fetchDreamChats(String? dreamId) async {
    try {
      if (dreamId == null) return null;
      final request = ModelQueries.list(Chat.classType, where: Chat.DREAMID.eq(dreamId));
      final response = await Amplify.API.query(request: request).response;
      final chats = response.data?.items ?? <Chat?>[];

      for (Chat? chat in chats) {
        if (chat == null) continue;
        if (_chatsByDreamId[dreamId] == null) {
          _chatsByDreamId[dreamId] = [chat];
        } else {
          _chatsByDreamId[dreamId]!.add(chat);
        }
      }
      notifyListeners();
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return <Chat?>[];
  }

  Future<String?> createChat(String dreamId, String text, ChatRoleType role) async {
    try {
      List<Chat>? list = getChatListById(dreamId);
      int chatIndex = 0;
      if (list != null && list.isNotEmpty) {
        chatIndex = list.last.chatIndex ?? 0;
        chatIndex++;
      }
      String? userId = await _userService.retrieveCurrentUserId();

      if (userId == null) {
        safePrint('User ID is null');
        return null;
      }
      final chat = Chat(dreamID: dreamId, text: text, role: role, userID: userId, chatIndex: chatIndex);
      final request = ModelMutations.create(chat);
      final response = await Amplify.API.mutate(request: request).response;

      final createdChat = response.data;
      if (createdChat == null) {
        safePrint('errors: ${response.errors}');
        return null;
      }
      safePrint('Mutation result: ${createdChat.text}');

      placeChatInLists(dreamId, createdChat);
      notifyListeners();
      return createdChat.id;
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      return null;
    }
  }

  Future<bool> updateChat(String chatId, String dreamId, String text) async {
    try {
      List<Chat>? list = getChatListById(dreamId);
      Chat? chat = list?.firstWhere((element) => element.id == chatId);
      if (chat != null) {
        String? userId = await _userService.retrieveCurrentUserId();

        if (userId == null) {
          safePrint('User ID is null');
          return false;
        }
        final update =
            Chat(id: chatId, dreamID: dreamId, text: text, role: chat.role, userID: userId, chatIndex: chat.chatIndex);
        final request = ModelMutations.update(update);
        final response = await Amplify.API.mutate(request: request).response;

        final updatedChat = response.data;
        if (updatedChat == null) {
          safePrint('errors: ${response.errors}');
          return false;
        }
        safePrint('Mutation result: ${updatedChat.text}');
        placeChatInLists(dreamId, updatedChat);

        notifyListeners();
        return true;
      }
      return false;
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      return false;
    }
  }

  void placeChatInLists(String dreamID, Chat chat) {
    List<Chat> list = getChatListById(dreamID) ?? [];
    if (list.map((e) => e.id).contains(chat.id)) {
      list.removeWhere((element) => element.id == chat.id);
    }
    list.add(chat);
    _chatsByDreamId[dreamID] = list;
  }
}
