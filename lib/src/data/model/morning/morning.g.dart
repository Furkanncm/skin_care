// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'morning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Morning _$MorningFromJson(Map<String, dynamic> json) => Morning(
      cosmetics: (json['cosmetics'] as List<dynamic>)
          .map((e) => Cosmetic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MorningToJson(Morning instance) => <String, dynamic>{
      'cosmetics': instance.cosmetics,
    };
