import 'package:dream_catcher/styles/styles.dart';
import 'package:flutter/material.dart';

/// Styling for any TextFields and submit buttons for auth screens.
/// Allows for dynamic counts of text editing inputs using formCount
class AuthForm extends StatelessWidget {
  final int formCount;
  final List<Widget> textFields;
  final List<String>? bottomLabels;
  final Widget submitButton;

  const AuthForm({
    Key? key,
    this.formCount = 1,
    required this.textFields,
    required this.submitButton,
    this.bottomLabels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._generateForms(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
          child: submitButton,
        ),
      ],
    );
  }

  /// allow for dynamic count of text editing inputs.
  /// use _buildForm
  List<Widget> _generateForms() {
    List<Widget> forms = [];
    for (int i = 0; i < formCount; i++) {
      forms.add(
        _buildForm(textField: textFields[i], bottomLabel: bottomLabels?[i]),
      );
      forms.add(SizedBox(height: formCount == 1 ? 20.0 : 10.0));
    }
    return forms;
  }

  /// styling of the form, include description of the form and field
  Widget _buildForm({required Widget textField, String? bottomLabel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textField,
        if (bottomLabel != null)
          Column(
            children: [
              const SizedBox(height: 5.0),
              Text(
                bottomLabel,
                style: Styles.uiLightSmall,
              ),
            ],
          ),
      ],
    );
  }
}
