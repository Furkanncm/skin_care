import 'package:bloc_clean_architecture/src/common/theme/theme_colors.dart';
import 'package:flutter/material.dart';

final class DarkTheme {
  static ThemeData get theme => ThemeData.dark(useMaterial3: true).copyWith(
        extensions: <ThemeExtension<dynamic>>[
          const ThemeColors(
            specialBottomSheetBackgroundColor: Colors.orangeAccent,
          ),
        ],
      );
}
