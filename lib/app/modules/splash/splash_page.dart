import 'package:flutter/material.dart';
import 'package:routime_app/app/core/widgets/routime_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RoutimeLogo(),
      ),
    );
  }
}
