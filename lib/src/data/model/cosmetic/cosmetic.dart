import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cosmetic.g.dart';

@JsonSerializable()
@immutable
 class Cosmetic implements SelectableSearchMixin{
  final String? name;
  final String? description;
  final String? type;
  final String? image;
  final String? color;

  Cosmetic({
    this.name,
    this.description,
    this.type,
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
  String? get title =>name;
}
