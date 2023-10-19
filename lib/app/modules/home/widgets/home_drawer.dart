import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:routime_app/app/core/auth/auth_provider.dart';
import 'package:routime_app/app/core/ui/theme_extension.dart';
import 'package:routime_app/app/services/user/user_service.dart';
import 'package:validatorless/validatorless.dart';

class HomeDrawer extends StatelessWidget {
  final _nameVN = ValueNotifier<String>('');
  final _nameKey = GlobalKey<FormState>();

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Selector<AuthProvider, String>(
                          selector: (context, authProvider) {
                            return authProvider.user?.displayName ??
                                'Não informado';
                          },
                          builder: (_, value, __) {
                            return Text(
                              value,
                              style: context.textTheme.titleMedium,
                            );
                          },
                        ),
                        Selector<AuthProvider, String>(
                          selector: (context, authProvider) {
                            return authProvider.user?.email ?? 'Não informado';
                          },
                          builder: (_, value, __) {
                            return Text(
                              value,
                              style: context.textTheme.titleMedium,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    icon: Icon(
                      Icons.edit,
                      color: context.primaryColor,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: _nameKey,
                          child: TextFormField(
                            decoration:
                                const InputDecoration(label: Text('Nome')),
                            validator:
                                Validatorless.required('Nome obrigatório'),
                            onChanged: (value) => _nameVN.value = value,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              bool formValid =
                                  _nameKey.currentState?.validate() ?? false;
                              if (formValid) {
                                Loader.show(context);
                                await context
                                    .read<UserService>()
                                    .updateDisplayName(_nameVN.value);
                                Loader.hide();
                              }
                            },
                            child: const Text('Confirmar'),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
            title: Text('Alterar Dados'),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    icon: Icon(
                      Icons.warning,
                      color: context.primaryColor,
                    ),
                    title: const Text('Aviso'),
                    content: const Text('Deseja realmente sair da sua conta?'),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () =>
                                context.read<AuthProvider>().logout(),
                            child: const Text('Confirmar'),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
            title: Text('Sair'),
          ),
        ],
      ),
    );
  }
}
