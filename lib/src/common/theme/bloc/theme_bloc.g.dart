// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeState _$ThemeStateFromJson(Map<String, dynamic> json) => ThemeState(
      colorScheme: json['colorScheme'] == null
          ? null
          : MyColorSchemeDto.fromJson(
              json['colorScheme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ThemeStateToJson(ThemeState instance) =>
    <String, dynamic>{
      'colorScheme': instance.colorScheme,
    };
