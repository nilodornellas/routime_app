import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routime_app/app/core/ui/constants.dart';

sealed class RoutimeUiConfig {
  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.mandaliTextTheme(),
        primaryColor: const Color(0xff8C52FF),
        primaryColorLight: const Color(0xffc6aaff),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsConstants.purple,
            foregroundColor: Colors.white,
          ),
        ),
        useMaterial3: true,
      );
}
