import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:dream_catcher/routing/router.dart';
import 'package:dream_catcher/screens/auth/auth_controller.dart';
import 'package:dream_catcher/screens/auth/auth_verify_code.dart';
import 'package:dream_catcher/screens/auth/sign_in.dart';
import 'package:dream_catcher/screens/auth/sign_up.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/utils/utils.dart';
import 'package:flutter/material.dart';

/// This is the new SignIn page.
/// This handles all cases and uses AuthController to change between the 3 possible screens
/// for logging into the app.
class AuthBase extends StatefulWidget {
  final Map<String, String>? params;

  const AuthBase({
    Key? key,
    this.params,
  }) : super(key: key);

  @override
  State<AuthBase> createState() => _AuthBaseState();
}

class _AuthBaseState extends State<AuthBase> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
    _authController.addListener(() {
      if (mounted) setState(() {}); // force rebuild
    });
    // listen for changes to the route - in case join link is passed
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils.log('AuthBase.build called with route ${router.currentConfiguration}');
    return ChangeNotifierBuilder(
      notifier: _authController,
      builder: ((context, authController, child) {
        DecorationImage? image;
        Widget body = Container();
        // if (_authController.isVerify) {
        //   body = AuthVerifyCode(authController: _authController);
        // } else
        if (_authController.isVerify) {
          body = AuthVerifyCode(authController: _authController);
        } else if (_authController.isSignIn) {
          body = AuthSignIn(authController: _authController);
        } else {
          body = AuthSignUp(authController: _authController);
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(color: Styles.wine, image: image),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(constraints: const BoxConstraints(maxWidth: 375.0), child: body),
              ),
            ),
          ),
        );
      }),
    );
  }
}
