import 'package:firebase_auth/firebase_auth.dart';
import 'package:routime_app/app/repositories/user/user_repositoy.dart';
import 'package:routime_app/app/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);
}