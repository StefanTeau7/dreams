import 'package:dream_catcher/screens/app/dream_collection.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Material(child: MaterialApp(home: Scaffold(body: DreamCollection())));
  }
}
