// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUserCredentials _$MyUserCredentialsFromJson(Map<String, dynamic> json) =>
    MyUserCredentials(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$MyUserCredentialsToJson(MyUserCredentials instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
