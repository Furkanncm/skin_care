// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'culture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Culture _$CultureFromJson(Map<String, dynamic> json) => Culture(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      flag: json['flag'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => Resource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CultureToJson(Culture instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'flag': instance.flag,
      'resources': instance.resources,
    };
