import 'package:dream_catcher/screens/auth/auth_controller.dart';
import 'package:dream_catcher/screens/auth/auth_form.dart';
import 'package:dream_catcher/screens/auth/auth_form_toggle_button.dart';
import 'package:dream_catcher/screens/auth/auth_layout.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/utils/utils.dart';
import 'package:dream_catcher/widgets/async_action_button.dart';
import 'package:dream_catcher/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';

/// VerifyCode screen, cannot create an account or login to existing account.
/// Use AuthLayout to format layout.
class AuthVerifyCode extends StatelessWidget {
  final AuthController authController;
  const AuthVerifyCode({Key? key, required this.authController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      callToAction: RichText(
        text: TextSpan(
          children: <InlineSpan>[
            const TextSpan(text: 'A code was sent to ', style: Styles.uiSmall),
            TextSpan(text: Utils.prettyPhone(authController.emailController.text), style: Styles.uiBoldSmall),
            const TextSpan(text: '. Please enter it below to verify your phone number.', style: Styles.uiSmall),
          ],
        ),
      ),
      form: AuthForm(
        formCount: 1,
        textFields: [
          LabeledTextField(
            label: 'Verification code',
            labelStyle: Styles.uiLightMedium,
            controller: authController.codeController,
            autofocus: true,
            maxLines: 1,
            keyboardType: TextInputType.number,
            onChanged: (_) => authController.validateCode(),
            onSubmitted:
                authController.isCodeValid ? (_) => authController.asyncButtonController.triggerPressed() : null,
          ),
        ],
        submitButton: AsyncActionButton(
          label: 'Continue',
          onPressed: authController.isCodeValid ? () async => authController.confirmUser() : null,
          controller: authController.asyncButtonController,
        ),
      ),
      footer: AuthFormToggleButton(
        question: 'Didn\'t get the message? ',
        buttonString: 'Resend the verification code',
        underlineButtonString: true,
        buttonOnTap: () => authController.isSignUpValid ? authController.setSignUp() : authController.setSignIn(),
      ),
    );
  }
}
