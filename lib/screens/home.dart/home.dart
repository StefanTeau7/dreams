import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/models/Dream.dart';
import 'package:dream_catcher/screens/app/dream_collection.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/services/user_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserService _userService = getIt<UserService>();
  final DreamService _dreamService = getIt<DreamService>();
  final ChatService _chatService = getIt<ChatService>();

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() async {
    await _userService.retrieveCurrentUserId();
    List<Dream?> dreams = await _dreamService.fetchUserDreams();
    for (var dream in dreams) {
      if (dream != null) {
        _chatService.fetchDreamChats(dream.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold(body: DreamCollection()));
  }
}
