import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routime_app/app/core/validators/validators.dart';
import 'package:routime_app/app/core/widgets/routime_field.dart';
import 'package:routime_app/app/core/widgets/routime_logo.dart';
import 'package:routime_app/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<RegisterController>().addListener(() {
      final controller = context.read<RegisterController>();
      bool success = controller.success;
      String? error = controller.error;
      if (success) {
        Navigator.of(context).pop();
      } else if (error != null && error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    context.read<RegisterController>().removeListener(() {});
    super.dispose();
  }

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
            child: Form(
              key: _formKey,
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
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                          6, 'Senha deve possuis pelo menos 6 caracteres'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  RoutimeField(
                    label: 'Confirmar senha',
                    obscureText: true,
                    controller: _confirmPasswordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirma senha obrigatória'),
                      Validators.compare(
                        _passwordEC,
                        'Suas senahs não são iguais',
                      )
                    ]),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        context.read<RegisterController>().registerUser(
                              _emailEC.text,
                              _passwordEC.text,
                            );
                      }
                    },
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
          ),
        ],
      ),
    );
  }
}
