part of 'add_cosmetic_bloc.dart';

enum AddCosmeticStatus { loading, loaded }

final class AddCosmeticState extends Equatable {
  const AddCosmeticState({
    this.status = AddCosmeticStatus.loading,
    this.colorSchemes = const [],
    this.cultures,
    this.selectedCulture,
  });

  final AddCosmeticStatus status;
  final List<MyColorSchemeDto> colorSchemes;
  final List<Culture>? cultures;
  final Culture? selectedCulture;
  @override
  List<Object?> get props => [status, colorSchemes, cultures, selectedCulture];

  AddCosmeticState copyWith({
    AddCosmeticStatus? status,
    List<MyColorSchemeDto>? colorSchemes,
    List<Culture>? cultures,
    Culture? selectedCulture,
  }) {
    return AddCosmeticState(
      status: status ?? this.status,
      colorSchemes: colorSchemes ?? this.colorSchemes,
      selectedCulture: selectedCulture ?? this.selectedCulture,
      cultures: cultures ?? this.cultures,
    );
  }
}
