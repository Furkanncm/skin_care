import 'package:bloc_clean_architecture/src/data/model/localization/response/resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'culture.g.dart';

@immutable
@JsonSerializable()
final class Culture extends Equatable with BaseModel<Culture> {
  const Culture({
    this.id,
    this.name,
    this.description,
    this.flag,
    this.resources,
  });

  factory Culture.fromJson(Map<String, dynamic> json) => _$CultureFromJson(json);

  final String? id;
  final String? name;
  final String? description;
  final String? flag;
  final List<Resource>? resources;

  Locale? get locale {
    final splitted = name?.split('-');
    if (splitted.isNull || splitted!.length != 2) return null;
    return Locale(splitted.first, splitted.last);
  }

  @override
  Map<String, dynamic> toJson() => _$CultureToJson(this);

  @override
  List<Object?> get props => [id, name, description, flag];

  @override
  Culture fromJson(Map<String, Object?> json) => Culture.fromJson(json);
}
