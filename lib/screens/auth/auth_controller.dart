import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/utils/utils.dart';
import 'package:dream_catcher/widgets/async_action_button.dart';
import 'package:flutter/material.dart';

enum AuthStatus { unknown, authorized, unauthorized }

class AuthController extends ChangeNotifier {
  //final Auth _auth = getIt<Auth>();
  final AsyncButtonController _asyncButtonController = AsyncButtonController();
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get codeController => _codeController;

  bool _isSignUp = false;
  bool _isSignIn = false;
  bool _isVerify = false;
  bool _isContactValid = false;
  bool _isCodeValid = false;
  bool _isSignUpValid = false;
  bool _showDialog = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  void resetAllData() {
    _emailController.clear();
    _passwordController.clear();
    _codeController.clear();
    _isSignUp = false;
    _isSignIn = false;
    _isVerify = false;
    _isContactValid = false;
    _isCodeValid = false;
    _isSignUpValid = false;
    _showDialog = true;
  }

  bool get isSignUp => _isSignUp;
  bool get isSignIn => _isSignIn;
  bool get isVerify => _isVerify;
  bool get isSignUpValid => _isSignUpValid;
  bool get isContactValid => _isContactValid;
  bool get isCodeValid => _isCodeValid;

  AsyncButtonController get asyncButtonController => _asyncButtonController;

  void validateCode() {
    bool isValid = (_codeController.text.trim().length == 6);
    if (isValid != _isCodeValid) {
      _isCodeValid = isValid;
      notifyListeners();
    }

    if (isValid) WidgetsBinding.instance.addPostFrameCallback((_) => asyncButtonController.triggerPressed());
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  void login() async {
    SignInResult res = await Amplify.Auth.signIn(
      username: _emailController.text,
      password: _passwordController.text,
    );
    _isSignIn = !res.isSignedIn;
    notifyListeners();
  }

  Future<void> signUpUser() async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: _emailController.text,
        CognitoUserAttributeKey.phoneNumber: _passwordController.text,
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: _emailController.text,
        password: _passwordController.text,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      //  setState(() {
      //    isSignUpComplete = result.isSignUpComplete;
      //  });
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

// Use the boolean created before
  bool isSignUpComplete = false;

  Future<void> confirmUser() async {
    try {
      final result =
          await Amplify.Auth.confirmSignUp(username: _emailController.text, confirmationCode: _codeController.text);
      // setState(() {
      //   isSignUpComplete = result.isSignUpComplete;
      // });
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  void requestVerificationCode() {
    // amplify send code
  }

  void validateSignUp() {
    // only allow phone numbers when signing up
    bool isValid = Utils.isValidEmail(_emailController.text.trim()) || Utils.isValidPhone(_emailController.text.trim());
    if (isValid != _isSignUpValid) {
      _isSignUpValid = isValid;
      notifyListeners();
    }
  }

  // setters
  void setSignIn() {
    codeController.clear();
    _isSignIn = true;
    _isSignUp = false;
    _isVerify = false;
    notifyListeners();
  }

  void setSignUp() {
    codeController.clear();
    _isSignUp = true;
    _isSignIn = false;
    _isVerify = false;
    validateSignUp();
    notifyListeners();
  }

  void validateContact() {
    bool isValid = Utils.isValidPhone(_emailController.text.trim()) || Utils.isValidEmail(_emailController.text.trim());
    if (isValid != _isContactValid) {
      _isContactValid = isValid;
      notifyListeners();
    }
  }
}
