import 'package:dream_catcher/main_app.dart';
import 'package:dream_catcher/screens/auth/auth_controller.dart';
import 'package:dream_catcher/services/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String IOS = 'IOS';
const String ANDROID = 'ANDROID';
const String WEB = 'WEB';
const String MACOS = 'MACOS';
AuthStatus authStatus = AuthStatus.unknown;

// max size of wideLayout
const double MAX_SCREEN_WIDTH = 1200.0;
void main() async {
  print('Catching Dreams...');
  await dotenv.load(fileName: '.env');
  await registerServices();
  await initializeServices();
  runApp(const MainApp());
}
