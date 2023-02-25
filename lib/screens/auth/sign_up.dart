// import 'package:dream_catcher/screens/auth/auth_controller.dart';
// import 'package:dream_catcher/screens/auth/auth_form.dart';
// import 'package:dream_catcher/screens/auth/auth_form_toggle_button.dart';
// import 'package:dream_catcher/screens/auth/auth_layout.dart';
// import 'package:dream_catcher/styles/styles.dart';
// import 'package:dream_catcher/widgets/async_action_button.dart';
// import 'package:dream_catcher/widgets/labeled_text_field.dart';
// import 'package:flutter/material.dart';

// /// SignUp screen, cannot login existing account or verify code.
// /// Use AuthLayout to format layout.
// class AuthSignUp extends StatelessWidget {
//   final AuthController authController;
//   const AuthSignUp({Key? key, required this.authController}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AuthLayout(
//       callToAction: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           // if (!authController.isInviteLink) _buildInviteLinkReminder(),
//           // if (!authController.isInviteLink) const SizedBox(height: 20.0),
//           Text('Create a new account', style: Styles.headlineLarge),
//         ],
//       ),
//       form: AuthForm(
//         formCount: 1,
//         textFields: [
//           LabeledTextField(
//             label: 'What\'s your phone number?',
//             autofocus: true,
//             labelStyle: Styles.uiLightMedium,
//             controller: authController.contactController,
//             keyboardType: TextInputType.phone, // change this to phone when fully changed over
//             textInputAction: TextInputAction.go,
//             onChanged: (_) => authController.validateSignUp(),
//             onSubmitted:
//                 authController.isSignUpValid ? (_) => authController.asyncButtonController.triggerPressed() : null,
//           ),
//         ],
//         submitButton: AsyncActionButton(
//           label: 'Continue',
//           onPressed: authController.isSignUpValid ? () => authController.requestVerificationCode(context) : null,
//           controller: authController.asyncButtonController,
//         ),
//       ),
//       footer: Column(
//         children: [
//           const SizedBox(height: 5.0),
//           //    Align(alignment: Alignment.centerLeft, child: _buildTermsAndAgreements()),
//           const SizedBox(height: 15.0),
//           AuthFormToggleButton(
//             question: 'Already have an account? ',
//             buttonString: 'Sign in',
//             buttonOnTap: () => authController.setSignIn(),
//           ),
//         ],
//       ),
//     );
//   }

//   /// text format and style for terms and agreement
//   // Widget _buildTermsAndAgreements() {
//   //   return RichText(
//   //     text: TextSpan(
//   //       children: <InlineSpan>[
//   //         const TextSpan(text: 'By clicking above, you confirm that you are ', style: Styles.uiSmall),
//   //         const TextSpan(text: 'at least 13 years old, ', style: Styles.uiBoldSmall),
//   //         const TextSpan(text: 'and you agree to abide by the ', style: Styles.uiSmall),
//   //         WidgetSpan(
//   //           child: InkWell(
//   //             onTap: () async => await launchUrl(Uri.parse('https://www.joinable.us/terms-of-service')),
//   //             child: Text(
//   //               'Membership Agreement',
//   //               style: Styles.uiBoldSmall.copyWith(decoration: TextDecoration.underline),
//   //             ),
//   //           ),
//   //         ),
//   //         const TextSpan(text: ' and ', style: Styles.uiSmall),
//   //         WidgetSpan(
//   //           child: InkWell(
//   //             onTap: () async => await launchUrl(Uri.parse('https://www.joinable.us/privacy-policy')),
//   //             child: Text(
//   //               'Privacy Policy',
//   //               style: Styles.uiBoldSmall.copyWith(decoration: TextDecoration.underline),
//   //             ),
//   //           ),
//   //         ),
//   //         const TextSpan(text: '.', style: Styles.uiSmall),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // Widget _buildInviteLinkReminder() {
//   //   return InlineAlert(
//   //       message: RichText(
//   //     textAlign: TextAlign.center,
//   //     text: TextSpan(
//   //       children: <TextSpan>[
//   //         TextSpan(
//   //           text: 'If you have an invitation, go back and click the ',
//   //           style: Styles.uiSmall.copyWith(fontSize: 15.0),
//   //         ),
//   //         TextSpan(text: 'Join button', style: Styles.uiBoldSmall.copyWith(fontSize: 15.0))
//   //       ],
//   //     ),
//   //   ));
//   // }
// }
