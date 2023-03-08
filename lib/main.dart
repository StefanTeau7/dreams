import 'package:dream_catcher/main_app.dart';
import 'package:dream_catcher/services/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String IOS = 'IOS';
const String ANDROID = 'ANDROID';
const String WEB = 'WEB';
const String MACOS = 'MACOS';
String AI_MODEL_ID = "gpt-3.5-turbo";

// max size of wideLayout
const double MAX_SCREEN_WIDTH = 1200.0;
void main() async {
  print('Catching Dreams...');
  await dotenv.load(fileName: '.env');
  await registerServices();
  await initializeServices();
  runApp(const MainApp());
}
