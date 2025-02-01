// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentCommand _$CommentCommandFromJson(Map<String, dynamic> json) =>
    CommentCommand(
      postId: (json['postId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommentCommandToJson(CommentCommand instance) =>
    <String, dynamic>{
      'postId': instance.postId,
    };
