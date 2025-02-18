// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evening.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evening _$EveningFromJson(Map<String, dynamic> json) => Evening(
      cosmetics: (json['cosmetics'] as List<dynamic>)
          .map((e) => Cosmetic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EveningToJson(Evening instance) => <String, dynamic>{
      'cosmetics': instance.cosmetics,
    };
