part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class _LocalizationChangedEvent extends LocalizationEvent {
  const _LocalizationChangedEvent(this.culture);

  final Culture culture;

  @override
  List<Object> get props => [culture];
}
