import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:routime_app/app/repositories/user/user_repositoy.dart';
import 'package:routime_app/app/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(
    Uint8List? filePhoto,
    String name,
    String email,
    String password,
  ) =>
      _userRepository.register(filePhoto, name, email, password);

  @override
  Future<User?> login(String email, String password) =>
      _userRepository.login(email, password);

  @override
  Future<void> forgotPassword(String email) =>
      _userRepository.forgotPassword(email);

  @override
  Future<void> logout() => _userRepository.logout();

  @override
  Future<void> updateDisplayName(String name) =>
      _userRepository.updateDisplayName(name);
}
