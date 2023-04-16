import 'package:dream_catcher/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextStyle? labelStyle;
  final String? hint;

  // optional configuration we pass through directly to the TextField
  final Function(String)? onChanged;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final TextInputType? keyboardType;
  final bool? enableSuggestions;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final void Function(dynamic _)? onSubmitted;
  final bool? autocorrect;
  final int? maxLength;
  final bool? autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final Color? color;
  final FocusNode? focusNode;

  LabeledTextField({
    required this.controller,
    required this.label,
    this.labelStyle,
    this.hint,
    this.onChanged,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.keyboardType,
    this.enableSuggestions,
    this.textCapitalization,
    this.textInputAction,
    this.onSubmitted,
    this.autocorrect,
    this.maxLength,
    this.autofocus,
    this.focusNode,
    this.inputFormatters,
    this.color,
  }) : super(key: ValueKey('${controller.hashCode}$label'));

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Center(child: Text(label, style: labelStyle ?? Styles.uiLightMedium)),
      const SizedBox(height: 5),
      Flexible(
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          style: Styles.uiMedium,
          decoration: Styles.getChatDecoration(hint ?? ''),
          textCapitalization: textCapitalization ?? TextCapitalization.sentences,
          keyboardType: keyboardType,
          enableSuggestions: enableSuggestions ?? false,
          autocorrect: autocorrect ?? false,
          textInputAction: textInputAction,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          onSubmitted: onSubmitted,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          autofocus: autofocus ?? false,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
        ),
      )
    ]);
  }
}
