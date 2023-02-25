import 'package:dream_catcher/main_app.dart';
import 'package:dream_catcher/services/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  print('Catching Dreams...');
  await dotenv.load(fileName: '.env');
  await registerServices();
  await initializeServices();
  runApp(const MainApp());
}
