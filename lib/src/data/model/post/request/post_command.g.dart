// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommand _$PostCommandFromJson(Map<String, dynamic> json) => PostCommand(
      start: (json['_start'] as num?)?.toInt(),
      limit: (json['_limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PostCommandToJson(PostCommand instance) =>
    <String, dynamic>{
      '_start': instance.start,
      '_limit': instance.limit,
    };
