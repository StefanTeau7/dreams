import 'package:dream_catcher/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Renders a Lottie asset if the client has Lottie support, otherwise
/// renders a fallback asset if Lottie is not supported.
class CompatibleLottie extends StatelessWidget {
  final String asset, fallbackAsset;

  final double width, height;

  const CompatibleLottie({
    required this.asset,
    required this.fallbackAsset,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils.log('usingCanvasKit=$isCanvasKit');

    if (isCanvasKit || !kIsWeb) {
      // if canvaskit web renderer or mobile app
      return Lottie.asset(
        asset,
        height: height,
        width: width,
        fit: BoxFit.contain,
      );
    }
    // HTML web renderer does not render Lottie asset correctly, so use the
    // static fallback asset instead of a Lottie.
    return Container(
      padding: const EdgeInsets.all(30),
      height: height,
      width: width,
      child: Image.asset(
        fallbackAsset,
        fit: BoxFit.contain,
      ),
    );
  }
}
