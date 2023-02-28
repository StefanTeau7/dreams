import 'package:dream_catcher/screens/auth/auth_controller.dart';
import 'package:dream_catcher/screens/auth/auth_form.dart';
import 'package:dream_catcher/screens/auth/auth_form_toggle_button.dart';
import 'package:dream_catcher/screens/auth/auth_layout.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/widgets/async_action_button.dart';
import 'package:dream_catcher/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';

/// SignUp screen, cannot login existing account or verify code.
/// Use AuthLayout to format layout.
class AuthSignUp extends StatelessWidget {
  final AuthController authController;
  const AuthSignUp({Key? key, required this.authController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      callToAction: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // if (!authController.isInviteLink) _buildInviteLinkReminder(),
          // if (!authController.isInviteLink) const SizedBox(height: 20.0),
          Text('Create a new account', style: Styles.headlineLarge),
        ],
      ),
      form: AuthForm(
        formCount: 1,
        textFields: [
          LabeledTextField(
            label: 'Email/phone',
            autofocus: true,
            labelStyle: Styles.uiLightMedium,
            controller: authController.emailController,
            keyboardType: TextInputType.phone, // change this to phone when fully changed over
            textInputAction: TextInputAction.go,
            onChanged: (_) => authController.validateSignUp(),
            onSubmitted:
                authController.isSignUpValid ? (_) => authController.asyncButtonController.triggerPressed() : null,
          ),
          LabeledTextField(
            label: 'Password',
            autofocus: true,
            labelStyle: Styles.uiLightMedium,
            controller: authController.passwordController,
            keyboardType: TextInputType.phone, // change this to phone when fully changed over
            textInputAction: TextInputAction.go,
            onChanged: (_) => authController.validateSignUp(),
            onSubmitted:
                authController.isSignUpValid ? (_) => authController.asyncButtonController.triggerPressed() : null,
          ),
        ],
        submitButton: AsyncActionButton(
          label: 'Continue',
          onPressed: authController.isSignUpValid ? () => authController.signUpUser() : null,
          controller: authController.asyncButtonController,
        ),
      ),
      footer: Column(
        children: [
          const SizedBox(height: 5.0),
          //    Align(alignment: Alignment.centerLeft, child: _buildTermsAndAgreements()),
          const SizedBox(height: 15.0),
          AuthFormToggleButton(
            question: 'Already have an account? ',
            buttonString: 'Sign in',
            buttonOnTap: () => authController.setSignIn(),
          ),
        ],
      ),
    );
  }
}
