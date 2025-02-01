// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_control.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionControl _$VersionControlFromJson(Map<String, dynamic> json) =>
    VersionControl(
      newVersionAvailable: json['newVersionAvailable'] as bool?,
      forceUpdate: json['forceUpdate'] as bool?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      version: json['version'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$VersionControlToJson(VersionControl instance) =>
    <String, dynamic>{
      'newVersionAvailable': instance.newVersionAvailable,
      'forceUpdate': instance.forceUpdate,
      'title': instance.title,
      'content': instance.content,
      'version': instance.version,
      'url': instance.url,
    };
