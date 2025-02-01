part of 'localization_bloc.dart';

final class LocalizationState extends Equatable {
  const LocalizationState({this.culture});

  final Culture? culture;

  @override
  List<Object?> get props => [culture];

  LocalizationState copyWith({Culture? culture}) {
    return LocalizationState(
      culture: culture ?? this.culture,
    );
  }
}
