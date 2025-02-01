// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalizationData _$LocalizationDataFromJson(Map<String, dynamic> json) =>
    LocalizationData(
      culture: json['culture'] == null
          ? null
          : Culture.fromJson(json['culture'] as Map<String, dynamic>),
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => Resource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocalizationDataToJson(LocalizationData instance) =>
    <String, dynamic>{
      'culture': instance.culture,
      'resources': instance.resources,
    };
