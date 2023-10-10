import 'package:routime_app/app/core/exceptions/auth_exceptions.dart';
import 'package:routime_app/app/core/notifier/routime_change_notifier.dart';
import 'package:routime_app/app/services/user/user_service.dart';

class LoginController extends RoutimeChangeNotifier {
  final UserService _userService;

  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('Usuário ou senha inválidos');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
