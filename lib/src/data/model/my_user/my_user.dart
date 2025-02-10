import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_user.g.dart';

@immutable
@JsonSerializable()
final class MyUser extends BaseModel<MyUser> with EquatableMixin {
  MyUser({this.Username, this.id, this.name, this.surName, this.email, this.phone, this.password, this.birthDate, this.imagePath, this.gender});

  MyUser.notValid()
      : Username = null,
        id = null,
        name = null,
        surName = null,
        email = null,
        phone = null,
        password = null,
        birthDate = null,
        imagePath = null,
        gender = null;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  final String? Username;
  final String? id;
  final String? name;
  final String? surName;
  final String? email;
  final String? phone;
  final String? password;
  final DateTime? birthDate;
  final String? imagePath;
  final String? gender;

  @override
  MyUser fromJson(Map<String, Object?> json) => _$MyUserFromJson(json);

  // Firestore'dan gelen veriyi UserModel'e çeviren fonksiyon
  factory MyUser.fromMap(String id, Map<String, dynamic> data) {
    return MyUser(
      id: id,
      Username: data['Username'] as String?,
      name: data['name'] as String?,
      surName: data['surName'] as String?,
      email: data['email'] as String?,
      phone: data['phone'] as String?,
      password: data['password'] as String?,
      birthDate: DateTime.parse(data['birthDate'] as String),
      imagePath: data['imagePath'] as String?,
      gender: data['gender'] as String?,
    );
  }

  @override
  Map<String, Object?> toJson() => _$MyUserToJson(this);

  @override
  List<Object?> get props => [
        Username,
        id,
        name,
        surName,
        email,
        phone,
        password,
        birthDate,
        imagePath,
        gender,
      ];

  MyUser copyWith({
    String? Username,
    String? id,
    String? name,
    String? surName,
    String? title,
    String? email,
    String? phone,
    bool? isActive,
    String? language,
    String? password,
    DateTime? birthDate,
    String? imagePath,
    String? gender,
  }) {
    return MyUser(
      Username: Username ?? this.Username,
      id: id ?? this.id,
      name: name ?? this.name,
      surName: surName ?? this.surName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      imagePath: imagePath ?? this.imagePath,
      gender: gender ?? this.gender,
    );
  }
}
