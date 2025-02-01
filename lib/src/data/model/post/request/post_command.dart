import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_command.g.dart';

@JsonSerializable()
@immutable
final class PostCommand extends BaseModel<PostCommand> {
  const PostCommand({
    this.start,
    this.limit,
  });

  factory PostCommand.fromJson(Map<String, dynamic> json) => _$PostCommandFromJson(json);

  @JsonKey(name: '_start')
  final int? start;
  @JsonKey(name: '_limit')
  final int? limit;

  @override
  PostCommand fromJson(Map<String, Object?> json) => PostCommand.fromJson(json);

  @override
  Map<String, Object?> toJson() => _$PostCommandToJson(this);
}
