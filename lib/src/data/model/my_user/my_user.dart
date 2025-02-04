import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_user.g.dart';

@immutable
@JsonSerializable()
final class MyUser extends BaseModel<MyUser> with EquatableMixin {
  MyUser({this.userName, this.id, this.name, this.surName, this.title, this.email, this.phone, this.isActive, this.language, this.password});

  const MyUser.notValid()
      : userName = null,
        id = null,
        name = null,
        surName = null,
        title = null,
        email = null,
        phone = null,
        isActive = null,
        language = null,
        password = null;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  final String? userName;
  final String? id;
  final String? name;
  final String? surName;
  final String? title;
  final String? email;
  final String? phone;
  final bool? isActive;
  final String? language;
  final String? password;

  @override
  MyUser fromJson(Map<String, Object?> json) => _$MyUserFromJson(json);


 // Firestore'dan gelen veriyi UserModel'e çeviren fonksiyon
  factory MyUser.fromMap(String id, Map<String, dynamic> data) {
    return MyUser(
      id: id,
      userName: data['userName'] as String?,
      name: data['name'] as String?,
      surName: data['surName'] as String?,
      title: data['title'] as String?,
      email: data['email'] as String?,
      phone: data['phone'] as String?,
      isActive: data['isActive'] as bool?,
      language: data['language'] as String?,
      password: data['password'] as String?,
    );
  }

  @override
  Map<String, Object?> toJson() => _$MyUserToJson(this);

  @override
  List<Object?> get props => [
        userName,
        id,
        name,
        surName,
        title,
        email,
        phone,
        isActive,
        language,
        password,
      ];

  MyUser copyWith({
    String? userName,
    String? id,
    String? name,
    String? surName,
    String? title,
    String? email,
    String? phone,
    bool? isActive,
    String? language,
    String? password,
  }) {
    return MyUser(
      userName: userName ?? this.userName,
      id: id ?? this.id,
      name: name ?? this.name,
      surName: surName ?? this.surName,
      title: title ?? this.title,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      language: language ?? this.language,
      password: password??this.password
    );
  }
}
