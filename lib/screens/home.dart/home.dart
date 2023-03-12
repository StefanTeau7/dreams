import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/screens/app/dream_collection.dart';
import 'package:dream_catcher/services/user_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserService _userService = getIt<UserService>();

  @override
  void initState() {
    _userService.retrieveCurrentUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: DreamCollection()));
  }
}
