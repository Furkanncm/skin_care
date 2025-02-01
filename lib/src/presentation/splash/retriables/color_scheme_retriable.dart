import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/exceptions/splash_exception.dart';
import 'package:bloc_clean_architecture/src/domain/theme/theme_repository.dart';
import 'package:flutter_core/flutter_core.dart';

final class ColorSchemeRetriable extends Retriable<bool> {
  ColorSchemeRetriable({super.maxRetries, super.delayMultiplier});

  ThemeRepository get _themeRepository => getIt<ThemeRepository>();

  @override
  Future<bool> retryCallback() async {
    final colorSchemes = await _themeRepository.getColorSchemes();
    if (colorSchemes.isEmpty) {
      throw const SplashException('Renk şemaları yüklenemedi.');
    }
    return true;
  }
}
