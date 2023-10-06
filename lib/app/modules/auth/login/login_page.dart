import 'package:flutter/material.dart';
import 'package:routime_app/app/core/widgets/routime_field.dart';
import 'package:routime_app/app/core/widgets/routime_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                        child: Column(
                          children: [
                            RoutimeField(
                              label: 'E-mail',
                            ),
                            const SizedBox(height: 20),
                            RoutimeField(
                              label: 'Senha',
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {},
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
                                  onPressed: () {},
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
