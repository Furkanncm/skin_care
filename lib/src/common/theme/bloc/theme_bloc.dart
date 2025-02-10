import 'dart:ui';

import 'package:bloc_clean_architecture/src/data/model/color_scheme/dto/color_scheme_dto.dart';
import 'package:bloc_clean_architecture/src/domain/theme/theme_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'theme_bloc.g.dart';
part 'theme_event.dart';
part 'theme_state.dart';

@lazySingleton
class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._themeRepository) : super(const ThemeState()) {
    on<ThemeChangedEvent>(_changeTheme);
    on<ThemeChangeButtonClickedEvent>(_changeThemeButtonClicked);

    _themeRepository.status.listen((colorSchemeList) {
      if (state.colorScheme == null) {
        final platformBrightness = PlatformDispatcher.instance.platformBrightness;
        final colorScheme = colorSchemeList.where((element) => element.brightness == platformBrightness).first;
        add(ThemeChangedEvent(colorScheme: colorScheme));
      } else {
        final colorScheme = colorSchemeList.firstWhere((element) => element.brightness == state.colorScheme!.brightness);
        add(ThemeChangedEvent(colorScheme: colorScheme));
      }
    });
  }

  final ThemeRepository _themeRepository;
  bool isDarkMode = false;

  void _changeTheme(ThemeChangedEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(colorScheme: event.colorScheme));
  }

  void _changeThemeButtonClicked(ThemeChangeButtonClickedEvent event, Emitter<ThemeState> emit) {
    final colorSchemes = _themeRepository.getColorSchemesFromLocal();
    if (state.colorScheme?.brightness == Brightness.light) {
      emit(state.copyWith(colorScheme: colorSchemes.firstWhere((element) => element.brightness == Brightness.dark)));
      isDarkMode = true;
    } else {
      emit(state.copyWith(colorScheme: colorSchemes.firstWhere((element) => element.brightness == Brightness.light)));
      isDarkMode = false;
    }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) => ThemeState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ThemeState state) => state.toJson();
}
