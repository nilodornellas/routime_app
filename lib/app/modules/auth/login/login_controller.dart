import 'package:routime_app/app/core/exceptions/auth_exceptions.dart';
import 'package:routime_app/app/core/notifier/routime_change_notifier.dart';
import 'package:routime_app/app/services/user/user_service.dart';

class LoginController extends RoutimeChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        _userService.logout();
        setError('Usuário ou senha inválidos');
      }
    } on AuthException catch (e) {
      _userService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para seu e-mail';
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro ao resetar senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
