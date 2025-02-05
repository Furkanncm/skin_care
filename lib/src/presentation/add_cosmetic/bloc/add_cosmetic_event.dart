part of 'add_cosmetic_bloc.dart';

sealed class AddCosmeticEvent extends Equatable {
  const AddCosmeticEvent();

  @override
  List<Object> get props => [];
}

final class AddCosmeticInitializedEvent extends AddCosmeticEvent {
  const AddCosmeticInitializedEvent();
}

final class AddCosmeticSelectCategoryEvent extends AddCosmeticEvent {
  AddCosmeticSelectCategoryEvent({required this.selectedCategory});

  final SkinCareCategory selectedCategory;
}

final class AddCosmeticSelectColorEvent extends AddCosmeticEvent {
  AddCosmeticSelectColorEvent({required this.selectedColor});

  final ColorCategory selectedColor;
}
