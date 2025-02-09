// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosmetic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cosmetic _$CosmeticFromJson(Map<String, dynamic> json) => Cosmetic(
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$CosmeticToJson(Cosmetic instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'color': instance.color,
    };
