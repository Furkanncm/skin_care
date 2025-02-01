import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fake_user.g.dart';

@JsonSerializable()
final class FakeUser extends Equatable with BaseModel<FakeUser> {
  const FakeUser({this.id, this.name});

  factory FakeUser.fromJson(Map<String, Object?> json) => _$FakeUserFromJson(json);

  final String? id;
  final String? name;

  @override
  List<Object?> get props => [id, name];

  @override
  FakeUser fromJson(Map<String, Object?> json) => FakeUser.fromJson(json);

  @override
  Map<String, Object?> toJson() => _$FakeUserToJson(this);
}
