// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosmetic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cosmetic _$CosmeticFromJson(Map<String, dynamic> json) => Cosmetic(
      name: json['name'] as String?,
      brand: json['brand'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      image: json['image'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$CosmeticToJson(Cosmetic instance) => <String, dynamic>{
      'name': instance.name,
      'brand': instance.brand,
      'description': instance.description,
      'type': instance.type,
      'image': instance.image,
      'color': instance.color,
    };
