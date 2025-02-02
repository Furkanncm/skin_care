import 'package:bloc_clean_architecture/src/data/model/color_scheme/dto/color_scheme_dto.dart';
import 'package:flutter/material.dart';

abstract class SCColorSchemeDefault {
  static List<MyColorSchemeDto> get themes => [
        // Light Theme (Mavi ağırlıklı)
        const MyColorSchemeDto(
          brightness: Brightness.light,
          primary: Color(0xff3A86FF), // Canlı mavi
          onPrimary: Colors.white,
          secondary: Color(0xffA6C1EE), // Açık mavi
          onSecondary: Colors.black,
          error: Color(0xffFF6B6B),
          onError: Colors.white,
          surface: Color(0xffE0F2FE), // Açık mavi tonu
          onSurface: Colors.black,
          scaffoldBackgroundColor: Color(0xffF0F9FF), // Hafif mavi-beyaz
        ),
        // Dark Theme (Mavi ağırlıklı)
        const MyColorSchemeDto(
          brightness: Brightness.dark,
          primary: Color(0xff1E3A8A), // Koyu mavi
          onPrimary: Colors.white,
          secondary: Color(0xff3A86FF), // Canlı mavi
          onSecondary: Colors.white,
          error: Color(0xffFF6B6B),
          onError: Colors.white,
          surface: Color(0xff1E293B), // Koyu gri-mavi
          onSurface: Colors.white,
          scaffoldBackgroundColor: Color(0xff0F172A), // Derin koyu mavi
        ),
      ];
}
