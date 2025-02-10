// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      Username: json['Username'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      surName: json['surName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      imagePath: json['imagePath'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'Username': instance.Username,
      'id': instance.id,
      'name': instance.name,
      'surName': instance.surName,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'birthDate': instance.birthDate?.toIso8601String(),
      'imagePath': instance.imagePath,
      'gender': instance.gender,
    };
