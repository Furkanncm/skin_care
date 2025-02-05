part of 'add_cosmetic_bloc.dart';

sealed class AddCosmeticEvent extends Equatable {
  const AddCosmeticEvent();

  @override
  List<Object> get props => [];
}

final class AddCosmeticInitializedEvent extends AddCosmeticEvent {
  const AddCosmeticInitializedEvent();
}

final class LanguageChangedEvent extends AddCosmeticEvent {
  const LanguageChangedEvent({required this.culture});
  final Culture culture;

  @override
  List<Object> get props => [culture];
}
