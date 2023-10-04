import 'package:flutter/material.dart';
import 'package:routime_app/app/core/ui/theme_extension.dart';

class RoutimeLogo extends StatelessWidget {
  const RoutimeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo.png', height: 130),
        const SizedBox(height: 5),
        Text('Routime', style: context.textTheme.titleLarge),
      ],
    );
  }
}
