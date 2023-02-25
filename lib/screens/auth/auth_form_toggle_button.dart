import 'package:dream_catcher/styles/styles.dart';
import 'package:flutter/material.dart';

/// text button that allows switching between the 3 auth screens
class AuthFormToggleButton extends StatelessWidget {
  final String question;
  final String buttonString;
  final Function buttonOnTap;
  final bool underlineButtonString;
  final TextStyle? linkStyle;
  const AuthFormToggleButton({
    Key? key,
    required this.question,
    required this.buttonString,
    required this.buttonOnTap,
    this.underlineButtonString = true,
    this.linkStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        RichText(
          text: TextSpan(
            children: <InlineSpan>[
              TextSpan(text: question, style: Styles.uiMedium),
              WidgetSpan(
                child: InkWell(
                  onTap: () => buttonOnTap(),
                  child: Text(
                    buttonString,
                    style: linkStyle ??
                        Styles.uiMedium.copyWith(
                          color: Styles.wine,
                          decoration: underlineButtonString ? TextDecoration.underline : null,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
