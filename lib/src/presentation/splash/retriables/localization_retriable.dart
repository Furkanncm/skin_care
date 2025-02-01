import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/exceptions/splash_exception.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/domain/localization/localization_repository.dart';
import 'package:flutter_core/flutter_core.dart';

final class LocalizationRetriable extends Retriable<void> {
  LocalizationRetriable({super.maxRetries, super.delayMultiplier});

  LocalizationRepository get _localizationRepository => getIt<LocalizationRepository>();

  @override
  Future<bool> retryCallback() async {
    final culturesResponse = await _localizationRepository.getCultures().intercept();
    final cultures = culturesResponse.data ?? [];
    if (cultures.isEmpty) {
      throw const SplashException('Dil değişkenleri yüklenemedi.');
    }
    final selectedCulture = _localizationRepository.getSelectedCulture();
    if (selectedCulture.isNull) {
      final culture = cultures.first;
      return _localizationRepository.changeCulture(culture);
    }

    final culture = cultures.firstWhere((element) => element.id == selectedCulture!.id);
    return _localizationRepository.changeCulture(culture);
  }
}
