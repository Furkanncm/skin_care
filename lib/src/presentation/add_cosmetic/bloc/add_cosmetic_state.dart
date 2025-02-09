part of 'add_cosmetic_bloc.dart';

enum AddCosmeticStatus { loading, loaded }

final class AddCosmeticState extends Equatable {
  const AddCosmeticState({
    this.status = AddCosmeticStatus.loading,
    this.selectedCategory,
    this.selectedColor,
    this.image,
  });

  final AddCosmeticStatus status;
  final SkinCareCategory? selectedCategory;
  final ColorCategory? selectedColor;
  final File? image;

  @override
  List<Object?> get props => [status, selectedCategory, selectedColor , image];

  AddCosmeticState copyWith({
    AddCosmeticStatus? status,
    SkinCareCategory? selectedCategory,
    ColorCategory? selectedColor,
    File? image,
  }) {
    return AddCosmeticState(
      status: status ?? this.status,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedColor: selectedColor ?? this.selectedColor,
      image: image ?? this.image,
    );
  }
}
