// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
      cultureId: json['cultureId'] as String?,
      key: json['key'] as String?,
      value: json['value'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'cultureId': instance.cultureId,
      'key': instance.key,
      'value': instance.value,
      'description': instance.description,
    };
