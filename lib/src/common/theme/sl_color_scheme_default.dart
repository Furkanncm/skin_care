import 'package:bloc_clean_architecture/src/data/model/color_scheme/dto/color_scheme_dto.dart';
import 'package:flutter/material.dart';

abstract class SCColorSchemeDefault {
  static List<MyColorSchemeDto> get themes => [
        // Light Theme
        const MyColorSchemeDto(
          brightness: Brightness.light,
          primary: Color(0xffFCE7C8),
          onPrimary: Colors.black,
          secondary: Color(0xffB1C29E),
          onSecondary: Colors.black,
          error: Color(0xffFADA7A),
          onError: Colors.black,
          surface: Color(0xffF0A04B),
          onSurface: Colors.black,
          scaffoldBackgroundColor: Color(0xffFCE7C8),
        ),
        // Dark Theme
        const MyColorSchemeDto(
          brightness: Brightness.dark,
          primary: Color(0xffB1C29E),
          onPrimary: Colors.white,
          secondary: Color(0xffFCE7C8),
          onSecondary: Colors.white,
          error: Color(0xffF0A04B),
          onError: Colors.white,
          surface: Color(0xffFADA7A),
          onSurface: Colors.white,
          scaffoldBackgroundColor: Color(0xff121212),
        ),
      ];
}
