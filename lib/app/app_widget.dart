import 'package:flutter/material.dart';
import 'package:routime_app/app/core/ui/routime_ui_config.dart';
import 'package:routime_app/app/modules/auth/auth_module.dart';
import 'package:routime_app/app/modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routime',
      routes: {
        ...AuthModule().routers,
      },
      home: const SplashPage(),
      theme: RoutimeUiConfig.theme,
    );
  }
}
