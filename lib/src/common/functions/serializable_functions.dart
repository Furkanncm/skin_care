import 'package:flutter/material.dart';

// ignore: avoid_positional_boolean_parameters
int? boolToInt(bool? value) {
  if (value is bool) return value ? 1 : 0;
  return null;
}

bool? intToBool(int? value) {
  if (value is int) return value == 1;
  return null;
}

int? brightnessToInt(Brightness? value) {
  if (value is Brightness) return value == Brightness.light ? 1 : 0;
  return null;
}

Brightness? intToBrightness(int? value) {
  if (value is int) return value == 1 ? Brightness.light : Brightness.dark;
  return null;
}

String? colorToString(Color? value) {
  if (value is Color) return value.value.toRadixString(16);
  return null;
}

Color? stringToColor(String? value) {
  if (value is String) return Color(int.parse(value, radix: 16));
  return null;
}
