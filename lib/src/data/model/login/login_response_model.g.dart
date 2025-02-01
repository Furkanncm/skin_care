// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'login_response_model.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
//     LoginResponseModel(
//       accessToken: json['access_token'] as String?,
//       authTime: json['auth_time'] == null
//           ? null
//           : DateTime.parse(json['auth_time'] as String),
//       refreshToken: json['refresh_token'] as String?,
//       tokenType: json['token_type'] as String?,
//       expiresIn: (json['expires_in'] as num?)?.toInt(),
//       language: json['language'] as String?,
//     );

// Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
//     <String, dynamic>{
//       'access_token': instance.accessToken,
//       'refresh_token': instance.refreshToken,
//       'token_type': instance.tokenType,
//       'auth_time': instance.authTime?.toIso8601String(),
//       'expires_in': instance.expiresIn,
//       'language': instance.language,
//     };
