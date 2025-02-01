import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resource.g.dart';

@immutable
@JsonSerializable()
final class Resource {
  const Resource({
    this.cultureId,
    this.key,
    this.value,
    this.description,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);

  final String? cultureId;
  final String? key;
  final String? value;
  final String? description;

  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}
