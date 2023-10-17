import 'package:flutter/material.dart';
import 'package:routime_app/app/core/ui/routime_ui_theme.dart';
import 'package:routime_app/app/modules/auth/auth_module.dart';
import 'package:routime_app/app/modules/home/home_module.dart';
import 'package:routime_app/app/modules/splash/splash_page.dart';
import 'package:routime_app/app/navigator/routime_navigator.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routime',
      navigatorKey: RoutimeNavigator.navigatorKey,
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
      },
      home: const SplashPage(),
      theme: RoutimeUiConfig.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
