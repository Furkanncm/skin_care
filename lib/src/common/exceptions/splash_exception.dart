import 'package:flutter/material.dart';

@immutable
final class SplashException implements Exception {
  const SplashException(this.message);

  final String message;

  @override
  String toString() => message;
}
