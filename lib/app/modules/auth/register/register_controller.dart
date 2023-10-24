import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:routime_app/app/core/exceptions/auth_exceptions.dart';
import 'package:routime_app/app/core/notifier/routime_change_notifier.dart';
import 'package:routime_app/app/core/utils/image_picker.dart';
import 'package:routime_app/app/services/user/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends RoutimeChangeNotifier {
  final UserService _userService;
  Uint8List? image;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String name, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(image, name, email, password);
      if (user != null) {
        success();
      } else {
        setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      prefs.setBool('enableNavigation', true);
      hideLoading();
      notifyListeners();
    }
  }

  void selectImage() async {
    showLoading();
    notifyListeners();

    Uint8List img = await pickImage(ImageSource.gallery);
    image = img;

    hideLoading();
    notifyListeners();
  }
}
