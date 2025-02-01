import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@immutable
@JsonSerializable()
final class LoginDto extends BaseModel<LoginDto> {
  const LoginDto({
    this.accessToken,
    this.authTime,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
    this.language,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) => _$LoginDtoFromJson(json);
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @JsonKey(name: 'auth_time')
  final DateTime? authTime;
  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  final String? language;

  @override
  LoginDto fromJson(Map<String, Object?> json) => _$LoginDtoFromJson(json);

  @override
  Map<String, Object?> toJson() => _$LoginDtoToJson(this);

  @override
  String toString() {
    return 'LoginDto(accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, authTime: $authTime, expiresIn: $expiresIn, language: $language)';
  }
}
