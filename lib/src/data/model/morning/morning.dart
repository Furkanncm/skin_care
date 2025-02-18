import 'package:bloc_clean_architecture/src/data/model/cosmetic/cosmetic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'morning.g.dart';

@JsonSerializable()
@immutable
class Morning extends Equatable {
  final List<Cosmetic> cosmetics;

    Morning({
    required this.cosmetics
  });

  
  @override
  List<Object?> get props => [];
  Morning copyWith({
    List<Cosmetic>? cosmetics    
  }) {
    return Morning(
          cosmetics: cosmetics ?? this.cosmetics
    );
  }

    factory Morning.fromJson(Map<String, dynamic> json) => _$MorningFromJson(json);

  Map<String, dynamic> toJson() => _$MorningToJson(this);
}