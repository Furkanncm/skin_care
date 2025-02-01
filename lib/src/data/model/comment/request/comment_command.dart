import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_command.g.dart';

@JsonSerializable()
@immutable
final class CommentCommand extends BaseModel<CommentCommand> {
  const CommentCommand({
    this.postId,
  });

  factory CommentCommand.fromJson(Map<String, dynamic> json) => _$CommentCommandFromJson(json);

  final int? postId;

  @override
  CommentCommand fromJson(Map<String, Object?> json) => CommentCommand.fromJson(json);

  @override
  Map<String, Object?> toJson() => _$CommentCommandToJson(this);
}
