import 'package:flutter/material.dart';

class LightTheme {
  final ThemeData _theme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      onPrimary: Color(0xFF000000),
      primary: Color(0xFF233c4c),
      secondary: Color(0xFF32698f),
      tertiary: Color(0xFF1a9f8e),
      onTertiary: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
    )
  );

  ThemeData get theme => _theme;
}