import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutimeUiConfig {
  RoutimeUiConfig._();

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.mandaliTextTheme(),
        primaryColor: const Color(0xff8C52FF),
        primaryColorLight: const Color(0xffc6aaff),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8C52FF),
              foregroundColor: const Color(0xffffffff)),
        ),
        useMaterial3: true,
      );
}
