import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:routime_app/app/navigator/routime_navigator.dart';
import 'package:routime_app/app/services/user/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService;

  Future<void> logout() => _userService.logout();
  User? get user => _firebaseAuth.currentUser;

  void loadListener() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firebaseAuth.userChanges().listen((_) {
      notifyListeners();
    });
    _firebaseAuth.idTokenChanges().listen((user) {
      bool enableNavigation = prefs.getBool('enableNavigation') ?? true;

      notifyListeners();
      if (user != null) {
        if (enableNavigation) {
          RoutimeNavigator.to
              .pushNamedAndRemoveUntil('/home', (route) => false);
        }
      } else {
        RoutimeNavigator.to.pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}
