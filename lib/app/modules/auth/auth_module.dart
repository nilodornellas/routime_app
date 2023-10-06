import 'package:provider/provider.dart';
import 'package:routime_app/app/core/modules/routime_module.dart';
import 'package:routime_app/app/modules/auth/login/login_controller.dart';
import 'package:routime_app/app/modules/auth/login/login_page.dart';
import 'package:routime_app/app/modules/auth/register/register_controller.dart';
import 'package:routime_app/app/modules/auth/register/register_page.dart';

class AuthModule extends RoutimeModule {
  AuthModule()
      : super(bindings: [
          ChangeNotifierProvider(
            create: (_) => LoginController(),
          ),
          ChangeNotifierProvider(
            create: (_) => RegisterController(),
          ),
        ], routers: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
        });
}
