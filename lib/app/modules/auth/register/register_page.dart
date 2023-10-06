import 'package:flutter/material.dart';
import 'package:routime_app/app/core/widgets/routime_field.dart';
import 'package:routime_app/app/core/widgets/routime_logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 40),
          SizedBox(
            height: MediaQuery.of(context).size.width * .4,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: RoutimeLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                RoutimeField(label: 'E-mail'),
                const SizedBox(height: 20),
                RoutimeField(
                  label: 'Senha',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                RoutimeField(
                  label: 'Confirmar senha',
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: 160,
                    height: 40,
                    child: Center(
                      child: Text(
                        'Cadastrar',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
