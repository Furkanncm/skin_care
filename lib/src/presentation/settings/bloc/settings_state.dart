part of 'settings_bloc.dart';

enum SettingsStatus { loading, loaded }

final class SettingsState extends Equatable {
  const SettingsState({
    this.status = SettingsStatus.loading,
    this.colorSchemes = const [],
    this.cultures,
    this.selectedCulture,
  });

  final SettingsStatus status;
  final List<MyColorSchemeDto> colorSchemes;
  final List<Culture>? cultures;
  final Culture? selectedCulture;
  @override
  List<Object?> get props => [status, colorSchemes, cultures, selectedCulture];

  SettingsState copyWith({
    SettingsStatus? status,
    List<MyColorSchemeDto>? colorSchemes,
    List<Culture>? cultures,
    Culture? selectedCulture,
  }) {
    return SettingsState(
      status: status ?? this.status,
      colorSchemes: colorSchemes ?? this.colorSchemes,
      selectedCulture: selectedCulture ?? this.selectedCulture,
      cultures: cultures ?? this.cultures,
    );
  }
}
