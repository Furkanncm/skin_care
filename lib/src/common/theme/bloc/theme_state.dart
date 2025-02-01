part of 'theme_bloc.dart';

@immutable
@JsonSerializable()
class ThemeState extends Equatable with BaseModel<ThemeState> {
  const ThemeState({this.colorScheme});

  factory ThemeState.fromJson(Map<String, dynamic> json) => _$ThemeStateFromJson(json);

  final MyColorSchemeDto? colorScheme;

  @override
  Map<String, dynamic> toJson() => _$ThemeStateToJson(this);

  @override
  ThemeState fromJson(Map<String, Object?> json) => ThemeState.fromJson(json);

  @override
  List<Object?> get props => [colorScheme];

  ThemeState copyWith({MyColorSchemeDto? colorScheme}) {
    return ThemeState(
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }
}
