import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cosmetic.g.dart';

@JsonSerializable()
@immutable
class Cosmetic extends Equatable implements SelectableSearchMixin {
  final String? id;
  final String? name;
  final String? description;
  final String? category;
  final String? image;
  final String? color;

  Cosmetic({
    this.id,
    this.name,
    this.description,
    this.category,
    this.image,
    this.color,
  });

  factory Cosmetic.fromJson(Map<String, dynamic> json) => _$CosmeticFromJson(json);

  Map<String, dynamic> toJson() => _$CosmeticToJson(this);

  @override
  bool get active => false;

  @override
  bool filter(String query) => false;

  @override
  String? get subtitle => "";

  @override
  String? get title => name;

  @override
  List<Object?> get props => [id, name, description, category, image, color];
}
