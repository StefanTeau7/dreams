import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/services/dependency_injection.dart';
import 'package:dream_catcher/widgets/async_action_button.dart';
import 'package:flutter/material.dart';

class AuthController {
  //final Auth _auth = getIt<Auth>();
  final AsyncButtonController _asyncButtonController = AsyncButtonController();

  bool _isSignUp = false;
  bool _isSignIn = false;
  bool _isVerify = false;
  bool _isContactValid = false;
  bool _isCodeValid = false;
  bool _isSignUpValid = false;
  bool _showDialog = true;

  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  void resetAllData() {
    _contactController.clear();
    _codeController.clear();
    _isSignUp = false;
    _isSignIn = false;
    _isVerify = false;
    _isContactValid = false;
    _isCodeValid = false;
    _isSignUpValid = false;
    _showDialog = true;
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }
}
