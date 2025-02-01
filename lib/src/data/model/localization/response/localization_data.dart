import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'localization_data.g.dart';

@immutable
@JsonSerializable()
final class LocalizationData extends Equatable {
  const LocalizationData({
    this.culture,
    this.resources,
  });

  factory LocalizationData.fromJson(Map<String, dynamic> json) => _$LocalizationDataFromJson(json);

  final Culture? culture;
  final List<Resource>? resources;

  Map<String, dynamic> toJson() => _$LocalizationDataToJson(this);

  @override
  List<Object?> get props => [culture, resources];
}
