import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  AuthUser? _user;

  AuthUser? get user {
    return _user;
  }

  String? get userId {
    return _user?.userId;
  }

  Future<String?> retrieveCurrentUserId() async {
    if (userId != null) {
      return userId;
    } else {
      AuthUser authUser = await Amplify.Auth.getCurrentUser();
      _user = authUser;
      notifyListeners();
      return authUser.userId;
    }
  }
}
