import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../cosmetic/cosmetic.dart';

part 'evening.g.dart';

@JsonSerializable()
@immutable
class Evening extends Equatable {
  final List<Cosmetic> cosmetics;

  Evening({required this.cosmetics});

  @override
  List<Object?> get props => [];
  Evening copyWith({List<Cosmetic>? cosmetics}) {
    return Evening(cosmetics: cosmetics ?? this.cosmetics);
  }

  factory Evening.fromJson(Map<String, dynamic> json) => _$EveningFromJson(json);

  Map<String, dynamic> toJson() => _$EveningToJson(this);
}
