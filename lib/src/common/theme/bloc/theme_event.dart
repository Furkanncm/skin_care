part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

final class ThemeChangedEvent extends ThemeEvent {
  const ThemeChangedEvent({required this.colorScheme});
  final MyColorSchemeDto colorScheme;

  @override
  List<Object> get props => [colorScheme];
}

final class ThemeChangeButtonClickedEvent extends ThemeEvent {
  const ThemeChangeButtonClickedEvent();

  @override
  List<Object> get props => [];
}
