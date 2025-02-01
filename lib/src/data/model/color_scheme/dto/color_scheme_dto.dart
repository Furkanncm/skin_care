import 'package:bloc_clean_architecture/src/common/functions/serializable_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'color_scheme_dto.g.dart';

@immutable
@JsonSerializable()
final class MyColorSchemeDto extends Equatable with BaseModel<MyColorSchemeDto> {
  const MyColorSchemeDto({
    this.brightness,
    this.primary,
    this.onPrimary,
    this.secondary,
    this.onSecondary,
    this.error,
    this.onError,
    this.surface,
    this.onSurface,
    this.scaffoldBackgroundColor,
  });

  factory MyColorSchemeDto.fromJson(Map<String, dynamic> json) => _$MyColorSchemeDtoFromJson(json);
  @JsonKey(toJson: brightnessToInt, fromJson: intToBrightness)
  final Brightness? brightness;
  @JsonKey(toJson: colorToString, fromJson: stringToColor)
  final Color? primary;
  @JsonKey(toJson: colorToString, fromJson: stringToColor)
  final Color? onPrimary;
  @JsonKey(toJson: colorToString, fromJson: stringToColor)
  final Color? secondary;
  @JsonKey(toJson: colorToString, fromJson: stringToColor)
  final Color? onSecondary;
  @JsonKey(toJson: colorToString, fromJson: stringToColor)
  final Color? error;
  @JsonKey(toJson: colorToString, fromJson: stringToColor)
  final Color? onError;
  @JsonKey(toJson: colorToString, fromJson: stringToColor)
  final Color? surface;
  @JsonKey(toJson: colorToString, fromJson: stringToColor)
  final Color? onSurface;
  @JsonKey(toJson: colorToString, fromJson: stringToColor)
  final Color? scaffoldBackgroundColor;

  @override
  Map<String, dynamic> toJson() => _$MyColorSchemeDtoToJson(this);

  @override
  MyColorSchemeDto fromJson(Map<String, Object?> json) => MyColorSchemeDto.fromJson(json);

  @override
  List<Object?> get props => [brightness, primary, onPrimary, secondary, onSecondary, error, onError, surface, onSurface, scaffoldBackgroundColor];
}
