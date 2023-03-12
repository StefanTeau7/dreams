import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  late AuthUser _user;

  AuthUser get user {
    return _user;
  }

  String get userId {
    return _user.userId;
  }

  Future<AuthUser> retrieveCurrentUser() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    _user = authUser;
    return authUser;
  }
}
