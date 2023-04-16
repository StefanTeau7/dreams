import 'package:dream_catcher/styles/styles.dart';
import 'package:flutter/material.dart';

class SelfSavingTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;
  final int? minLines;
  final String hintText;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final FocusNode focusNode;

  const SelfSavingTextField(
    this.controller, {
    required this.onChanged,
    this.hintText = 'Type...',
    required this.focusNode,
    this.minLines,
    this.contentPadding,
    this.hintStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: minLines,
      maxLines: minLines,
      focusNode: focusNode,
      style: Styles.uiBoldExtraLarge.copyWith(color: Styles.white),
      decoration: Styles.getTitleDecoration(hintText),
      controller: controller,
      onChanged: (value) => onChanged(value),
    );
  }
}
