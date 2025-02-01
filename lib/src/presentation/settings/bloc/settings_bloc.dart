import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/color_scheme/dto/color_scheme_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:bloc_clean_architecture/src/domain/localization/localization_repository.dart';
import 'package:bloc_clean_architecture/src/domain/theme/theme_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._themeRepository, this._localizationRepository) : super(const SettingsState()) {
    on<SettingsInitializedEvent>(_onInitialized);
    on<LanguageChangedEvent>(_onLanguageChanged);
  }

  final ThemeRepository _themeRepository;
  final LocalizationRepository _localizationRepository;

  Future<void> _onInitialized(SettingsInitializedEvent event, Emitter<SettingsState> emit) async {
    final colorSchemes = await _themeRepository.getColorSchemes();
    final result = await _localizationRepository.getCultures().intercept();
    final cultures = result.data ?? <Culture>[];
    final selectedCulture = _localizationRepository.getSelectedCulture();
    if (selectedCulture.isNull) throw Exception('Selected culture is null');
    emit(state.copyWith(status: SettingsStatus.loaded, colorSchemes: colorSchemes, cultures: cultures, selectedCulture: selectedCulture));
  }

  Future<void> _onLanguageChanged(LanguageChangedEvent event, Emitter<SettingsState> emit) async {
    await _localizationRepository.changeCulture(event.culture);

    emit(state.copyWith(selectedCulture: event.culture));
  }
}
