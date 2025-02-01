import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_user.g.dart';

@immutable
@JsonSerializable()
final class MyUser extends BaseModel<MyUser> with EquatableMixin {
  const MyUser({
    this.userName,
    this.id,
    this.name,
    this.surName,
    this.title,
    this.email,
    this.phone,
    this.isActive,
    this.language,
  });

  const MyUser.notValid()
      : userName = null,
        id = null,
        name = null,
        surName = null,
        title = null,
        email = null,
        phone = null,
        isActive = null,
        language = null;

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

  @override
  MyUser fromJson(Map<String, Object?> json) => _$MyUserFromJson(json);

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
    );
  }
}
