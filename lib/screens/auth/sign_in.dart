import 'package:dream_catcher/screens/auth/auth_controller.dart';
import 'package:dream_catcher/screens/auth/auth_form.dart';
import 'package:dream_catcher/screens/auth/auth_form_toggle_button.dart';
import 'package:dream_catcher/screens/auth/auth_layout.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/widgets/async_action_button.dart';
import 'package:dream_catcher/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';

/// SignIn screen, cannot create an account or verify code.
/// Use AuthLayout to format layout.
class AuthSignIn extends StatelessWidget {
  final AuthController authController;
  const AuthSignIn({Key? key, required this.authController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      callToAction: GestureDetector(
        // hidden button to allow changing of servers
        //  onLongPress: () => authController.chooseServer(context),
        child: const Text('Sign back in', style: Styles.headlineLarge),
      ),
      form: AuthForm(
        formCount: 1,
        textFields: [
          LabeledTextField(
            label: 'Email/phone',
            labelStyle: Styles.uiLightMedium,
            controller: authController.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.go,
            autocorrect: false,
            onChanged: (_) => authController.validateContact(),
            onSubmitted:
                authController.isContactValid ? (_) => authController.asyncButtonController.triggerPressed() : null,
          ),
        ],
        submitButton: Column(
          children: [
            AsyncActionButton(
              label: 'Sign In',
              onPressed: authController.isContactValid ? () => authController.requestVerificationCode() : null,
              controller: authController.asyncButtonController,
            ),
          ],
        ),
      ),
      footer: AuthFormToggleButton(
        question: 'Don\'t have an account? ',
        buttonString: 'Sign up',
        buttonOnTap: () => authController.setSignUp(),
      ),
    );
  }
}
