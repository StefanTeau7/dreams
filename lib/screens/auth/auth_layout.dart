import 'package:dream_catcher/screens/auth/auth_form.dart';
import 'package:flutter/material.dart';

/// main layout for all 3 auth pages (sign in, sign up, verify)
class AuthLayout extends StatelessWidget {
  final Widget callToAction;
  final AuthForm form;
  final Widget footer;
  const AuthLayout({
    Key? key,
    required this.callToAction,
    required this.form,
    required this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
      child: Column(
        children: [
          Row(children: const [
            // insert dream_catcher logo
          ]),
          const SizedBox(height: 40.0),
          Align(alignment: Alignment.centerLeft, child: callToAction),
          const SizedBox(height: 20.0),
          form,
          footer,
        ],
      ),
    );
  }
}
