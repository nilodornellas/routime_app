import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routime_app/app/core/exceptions/auth_exceptions.dart';

import 'package:routime_app/app/repositories/user/user_repositoy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;

  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseStorage = firebaseStorage;

  Future<String> uploadImageToStore(String? childName, Uint8List file) async {
    Reference ref =
        _firebaseStorage.ref().child('profileImage').child('$childName');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String dowloadUrl = await snapshot.ref.getDownloadURL();
    return dowloadUrl;
  }

  @override
  Future<User?> register(
    Uint8List? filePhoto,
    String name,
    String email,
    String password,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('enableNavigation', false);
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (filePhoto != null) {
        String photoURL =
            await uploadImageToStore(userCredential.user?.uid, filePhoto);
        userCredential.user?.updatePhotoURL(photoURL);
      }
      userCredential.user?.updateDisplayName(name);
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      debugPrint('$e');
      debugPrint('$s');
      if (e.code == 'email-already-in-use') {
        throw AuthException(
          message: 'E-mail já utilizado, por favor escolha outro e-mail',
        );
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      debugPrint('$e');
      debugPrint('$s');
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      debugPrint('$e');
      debugPrint('$s');
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw AuthException(message: 'Login ou senha inválidos');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      // final loginMethods =
      //     await _firebaseAuth.fetchSignInMethodsForEmail(email);

      // if (loginMethods.contains('password')) {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      // } else {
      // throw AuthException(message: 'E-mail não cadastrado');
      // }
    } on PlatformException catch (e) {
      debugPrint('$e');
      throw AuthException(message: 'Erro ao resetar a senha');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      user.updateDisplayName(name);
      user.reload();
    }
  }
}
