import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routime_app/app/core/notifier/routime_listener_notifier.dart';
import 'package:routime_app/app/core/ui/theme_extension.dart';
import 'package:routime_app/app/core/validators/validators.dart';
import 'package:routime_app/app/core/widgets/routime_field.dart';
import 'package:routime_app/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    final defaultListener = RoutimeListenerNotifier(
      changeNotifier: context.read<RegisterController>(),
    );
    defaultListener.listener(
      context: context,
      successCallback: (notifier, listnerInstance) {
        listnerInstance.dispose();
        Navigator.of(context).pop();
      },
      everCallback: (notifier, listnerInstance) {
        listnerInstance.dispose();
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Stack(
              children: [
                context.read<RegisterController>().image == null
                    ? const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                          'https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg',
                        ),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(
                            context.read<RegisterController>().image!),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: () {
                      context.read<RegisterController>().selectImage();
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 35,
                      color: context.primaryColor,
                    ),
                  ),
                )
              ],
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
                      label: 'Nome',
                      controller: _emailEC,
                      validator: Validatorless.required('Nome obrigatório'),
                    ),
                    const SizedBox(height: 20),
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
      ),
    );
  }
}
