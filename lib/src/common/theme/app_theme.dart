import 'package:bloc_clean_architecture/src/common/theme/dark_theme.dart';
import 'package:bloc_clean_architecture/src/common/theme/light_theme.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark,
}

extension AppThemeExtension on AppTheme {
  ThemeData get theme => switch (this) {
        AppTheme.light => LightTheme.theme,
        AppTheme.dark => DarkTheme.theme,
      };
}
