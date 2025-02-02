import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cosmetic.g.dart';

@JsonSerializable()
@immutable
final class Cosmetic {
  final String? name;
  final String? brand;
  final String? description;
  final String? type;
  final String? image;
  final String? color;

  Cosmetic({
    this.name,
    this.brand,
    this.description,
    this.type,
    this.image,
    this.color,
  });

  factory Cosmetic.fromJson(Map<String, dynamic> json) => _$CosmeticFromJson(json);

  Map<String, dynamic> toJson() => _$CosmeticToJson(this);
}
