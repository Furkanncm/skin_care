// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosmetic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cosmetic _$CosmeticFromJson(Map<String, dynamic> json) => Cosmetic(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      color: json['color'] as String?,
      isMorning: json['isMorning'] as bool?,
      isEvening: json['isEvening'] as bool?,
    );

Map<String, dynamic> _$CosmeticToJson(Cosmetic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'color': instance.color,
      'isMorning': instance.isMorning,
      'isEvening': instance.isEvening,
    };
