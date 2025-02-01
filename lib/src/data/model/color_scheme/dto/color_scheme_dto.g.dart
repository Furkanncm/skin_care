// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_scheme_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyColorSchemeDto _$MyColorSchemeDtoFromJson(Map<String, dynamic> json) =>
    MyColorSchemeDto(
      brightness: intToBrightness((json['brightness'] as num?)?.toInt()),
      primary: stringToColor(json['primary'] as String?),
      onPrimary: stringToColor(json['onPrimary'] as String?),
      secondary: stringToColor(json['secondary'] as String?),
      onSecondary: stringToColor(json['onSecondary'] as String?),
      error: stringToColor(json['error'] as String?),
      onError: stringToColor(json['onError'] as String?),
      surface: stringToColor(json['surface'] as String?),
      onSurface: stringToColor(json['onSurface'] as String?),
      scaffoldBackgroundColor:
          stringToColor(json['scaffoldBackgroundColor'] as String?),
    );

Map<String, dynamic> _$MyColorSchemeDtoToJson(MyColorSchemeDto instance) =>
    <String, dynamic>{
      'brightness': brightnessToInt(instance.brightness),
      'primary': colorToString(instance.primary),
      'onPrimary': colorToString(instance.onPrimary),
      'secondary': colorToString(instance.secondary),
      'onSecondary': colorToString(instance.onSecondary),
      'error': colorToString(instance.error),
      'onError': colorToString(instance.onError),
      'surface': colorToString(instance.surface),
      'onSurface': colorToString(instance.onSurface),
      'scaffoldBackgroundColor':
          colorToString(instance.scaffoldBackgroundColor),
    };
