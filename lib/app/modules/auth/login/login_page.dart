import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routime_app/app/core/notifier/routime_listener_notifier.dart';
import 'package:routime_app/app/core/widgets/routime_field.dart';
import 'package:routime_app/app/core/widgets/routime_logo.dart';
import 'package:routime_app/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formlKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    RoutimeListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      successCallback: (notifier, listnerInstance) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const RoutimeLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Form(
                        key: _formlKey,
                        child: Column(
                          children: [
                            RoutimeField(
                              label: 'E-mail',
                              controller: _emailEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('E-mail obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ]),
                            ),
                            const SizedBox(height: 20),
                            RoutimeField(
                              label: 'Senha',
                              controller: _passwordEC,
                              obscureText: true,
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatória'),
                                Validatorless.min(6,
                                    'Senha deve conter pelo menos 6 caracteres'),
                              ]),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                final formValid =
                                    _formlKey.currentState?.validate() ?? false;
                                if (formValid) {
                                  context
                                      .read<LoginController>()
                                      .login(_emailEC.text, _passwordEC.text);
                                }
                              },
                              child: const SizedBox(
                                width: 160,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    'Login',
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Esqueceu a senha?'),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Não possui uma conta?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/register');
                                  },
                                  child: const Text('Cadastre-se'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // s
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
