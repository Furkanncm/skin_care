import 'package:bloc_clean_architecture/src/data/model/color_scheme/dto/color_scheme_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

extension SLColorSchemeExtension on MyColorSchemeDto {
  ThemeData get theme {
    SystemChrome.setSystemUIOverlayStyle(
      brightness == Brightness.light
          ? SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarContrastEnforced: true,
              systemNavigationBarColor: scaffoldBackgroundColor,
            )
          : SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarContrastEnforced: true,
              systemNavigationBarColor: scaffoldBackgroundColor,
            ),
    );

    return ThemeData(
      colorScheme: ThemeData().colorScheme.copyWith(
            brightness: brightness,
            primary: primary,
            onPrimary: onPrimary,
            secondary: secondary,
            onSecondary: onSecondary,
            error: error,
            onError: onError,
            surface: surface,
            onSurface: onSurface,
          ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      pageTransitionsTheme: _pageTransitionsTheme,
      appBarTheme: _appBarTheme,
      textSelectionTheme: _textSelectionTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dropdownMenuTheme: _dropdownMenuTheme,
      bottomSheetTheme: _bottomSheetTheme,
      cardTheme: _cardTheme,
      dialogTheme: _dialogTheme,
      listTileTheme: _listTileTheme,
      checkboxTheme: _checkboxTheme,
      radioTheme: _radioTheme,
    );
  }

  PageTransitionsTheme get _pageTransitionsTheme {
    return const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    );
  }

  AppBarTheme get _appBarTheme {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      systemOverlayStyle: brightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: onSurface,
        fontSize: 18,
      ),
    );
  }

  TextSelectionThemeData get _textSelectionTheme {
    return TextSelectionThemeData(
      cursorColor: onSurface?.withOpacity(0.6),
    );
  }

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: onSurface ?? Colors.black,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: onSurface ?? Colors.black, width: 0.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: error ?? Colors.red, width: 0.8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: error ?? Colors.red, width: 0.8),
        ),
      );

  DropdownMenuThemeData get _dropdownMenuTheme {
    return DropdownMenuThemeData(
      inputDecorationTheme: _inputDecorationTheme,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(surface),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  BottomSheetThemeData get _bottomSheetTheme {
    return BottomSheetThemeData(
      backgroundColor: surface,
    );
  }

  CardTheme get _cardTheme {
    return CardTheme(
      color: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  DialogTheme get _dialogTheme {
    return DialogTheme(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  ListTileThemeData get _listTileTheme {
    return ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      iconColor: onSurface,
    );
  }

  CheckboxThemeData? get _checkboxTheme {
    return brightness == Brightness.light
        ? null
        : CheckboxThemeData(
            fillColor: WidgetStateProperty.all(surface),
            checkColor: WidgetStateProperty.all(onSurface),
            overlayColor: WidgetStateProperty.all(surface),
          );
  }

  RadioThemeData? get _radioTheme {
    return brightness == Brightness.light
        ? null
        : RadioThemeData(
            fillColor: WidgetStateProperty.all(onSurface),
            overlayColor: WidgetStateProperty.all(onSurface),
          );
  }
}
