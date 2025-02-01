import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
@immutable
final class Comment extends BaseModel<Comment> {
  const Comment({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  @override
  Comment fromJson(Map<String, Object?> json) => Comment.fromJson(json);

  @override
  Map<String, Object?> toJson() => _$CommentToJson(this);

  @override
  String toString() {
    return 'Comment{postId: $postId, id: $id, name: $name, email: $email, body: $body}';
  }
}
