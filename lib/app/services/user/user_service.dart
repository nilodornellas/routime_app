import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';

abstract interface class UserService {
  Future<User?> register(
    Uint8List? filePhoto,
    String name,
    String email,
    String password,
  );
  Future<User?> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<void> logout();
  Future<void> updateDisplayName(String name);
}
