import 'package:dream_catcher/widgets/compatible_lottie.dart';
import 'package:flutter/material.dart';

class CantConnectScreen extends StatelessWidget {
  const CantConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CompatibleLottie(
                asset: 'assets/images/lottie/loader.json',
                fallbackAsset: 'assets/images/lottie/loader.json',
                width: 50,
                height: 50,
              ),
              Text('Can\'t connect to the DreamCatcher server'),
            ],
          ),
        ),
      ),
    );
  }
}
