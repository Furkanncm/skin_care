import 'package:flutter/material.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.specialBottomSheetBackgroundColor,
  });

  final Color? specialBottomSheetBackgroundColor;

  @override
  ThemeColors copyWith({Color? specialBottomSheetBackgroundColor}) {
    return ThemeColors(
      specialBottomSheetBackgroundColor: specialBottomSheetBackgroundColor ?? this.specialBottomSheetBackgroundColor,
    );
  }

  @override
  ThemeColors lerp(ThemeColors? other, double t) {
    if (other is! ThemeColors) {
      return this;
    }
    return ThemeColors(
      specialBottomSheetBackgroundColor: Color.lerp(specialBottomSheetBackgroundColor, other.specialBottomSheetBackgroundColor, t),
    );
  }
}
