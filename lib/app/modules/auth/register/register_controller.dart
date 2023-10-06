import 'package:routime_app/app/core/exceptions/auth_exceptions.dart';
import 'package:routime_app/app/core/notifier/routime_change_notifier.dart';
import 'package:routime_app/app/services/user/user_service.dart';

class RegisterController extends RoutimeChangeNotifier {
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      final user = await _userService.register(email, password);
      if (user != null) {
        success();
      } else {
        setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
