// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final bool? isMorning;
  final bool? isEvening;

  Cosmetic({
    this.id,
    this.name,
    this.description,
    this.category,
    this.image,
    this.color,
    this.isMorning,
    this.isEvening,
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
  List<Object?> get props => [id, name, description, category, image, color, isMorning,isEvening];

 Cosmetic copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? image,
    String? color,
    bool? isMorning,
    bool? isEvening,
  }) {
    return Cosmetic(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      color: color ?? this.color,
      isMorning: isMorning ?? this.isMorning,
      isEvening: isEvening ?? this.isEvening,
    );
  }
}
