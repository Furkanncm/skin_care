import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
@immutable
final class Post extends BaseModel<Post> {
  const Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  @override
  Post fromJson(Map<String, Object?> json) => Post.fromJson(json);

  @override
  Map<String, Object?> toJson() => _$PostToJson(this);

  @override
  String toString() {
    return 'Post{userId: $userId, id: $id, title: $title, body: $body}';
  }
}
