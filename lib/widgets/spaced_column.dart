import 'package:dream_catcher/styles/styles.dart';
import 'package:flutter/material.dart';

class SpacedColumn extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double? height;
  final bool showFirstSpace;

  const SpacedColumn(
      {Key? key,
      required this.children,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.mainAxisSize = MainAxisSize.min,
      this.showFirstSpace = true,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = this.height ?? Styles.columnSpacing;

    List<Widget> result = [];
    if (showFirstSpace) {
      result.add(SizedBox(
        height: height,
      ));
    }
    for (Widget widget in children) {
      result.add(widget);
      result.add(SizedBox(
        height: height,
      ));
    }

    return Column(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: result);
  }
}
