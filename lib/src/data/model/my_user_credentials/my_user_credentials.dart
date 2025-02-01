import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_user_credentials.g.dart';

@immutable
@JsonSerializable()
final class MyUserCredentials extends BaseModel<MyUserCredentials> {
  const MyUserCredentials({
    this.accessToken,
    this.refreshToken,
  });

  factory MyUserCredentials.fromJson(Map<String, dynamic> json) => _$MyUserCredentialsFromJson(json);

  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  @override
  MyUserCredentials fromJson(Map<String, Object?> json) => _$MyUserCredentialsFromJson(json);

  @override
  Map<String, Object?> toJson() => _$MyUserCredentialsToJson(this);
}
