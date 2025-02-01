import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_control.g.dart';

@JsonSerializable()
@immutable
final class VersionControl extends BaseModel<VersionControl> {
  const VersionControl({
    this.newVersionAvailable,
    this.forceUpdate,
    this.title,
    this.content,
    this.version,
    this.url,
  });

  factory VersionControl.fromJson(Map<String, Object?> json) => _$VersionControlFromJson(json);

  final bool? newVersionAvailable;
  final bool? forceUpdate;
  final String? title;
  final String? content;
  final String? version;
  final String? url;

  @override
  VersionControl fromJson(Map<String, Object?> json) => _$VersionControlFromJson(json);

  @override
  Map<String, Object?> toJson() => _$VersionControlToJson(this);
}
