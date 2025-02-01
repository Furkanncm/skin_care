import 'package:bloc_clean_architecture/src/data/model/color_scheme/dto/color_scheme_dto.dart';
import 'package:flutter/material.dart';

abstract class SLColorSchemeDefault {
  static List<MyColorSchemeDto> get themes => [
        const MyColorSchemeDto(
          brightness: Brightness.light,
          primary: Color(0xffC13A82),
          onPrimary: Colors.white,
          secondary: Colors.black,
          onSecondary: Colors.white,
          error: Color(0xffFF1800),
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          scaffoldBackgroundColor: Color(0xffF5F6F8),
        ),
        const MyColorSchemeDto(
          brightness: Brightness.dark,
          primary: Color(0xff8E2C63),
          onPrimary: Colors.white,
          secondary: Colors.black,
          onSecondary: Colors.white,
          error: Color(0xffE53935),
          onError: Colors.white,
          surface: Color(0xff404040),
          onSurface: Colors.white,
          scaffoldBackgroundColor: Color(0xff121212),
        ),
      ];
}
