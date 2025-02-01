part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

final class SettingsInitializedEvent extends SettingsEvent {
  const SettingsInitializedEvent();
}

final class LanguageChangedEvent extends SettingsEvent {
  const LanguageChangedEvent({required this.culture});
  final Culture culture;

  @override
  List<Object> get props => [culture];
}
