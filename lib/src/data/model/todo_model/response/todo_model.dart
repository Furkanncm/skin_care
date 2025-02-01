import 'package:bloc_clean_architecture/src/common/functions/serializable_functions.dart';
import 'package:bloc_clean_architecture/src/common/sqflite_manager/tables/todo_table.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
@immutable
final class TodoModel extends Equatable with BaseModel<TodoModel> {
  const TodoModel({
    this.id,
    this.title,
    this.description,
    this.dateTime,
    this.isSelected,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);

  @JsonKey(name: TodoTable.idFieldName)
  final int? id;
  @JsonKey(name: TodoTable.titleFieldName)
  final String? title;
  @JsonKey(name: TodoTable.descriptionFieldName)
  final String? description;
  @JsonKey(name: TodoTable.dateTimeFieldName)
  final DateTime? dateTime;
  @JsonKey(name: TodoTable.isSelectedFieldName, toJson: boolToInt, fromJson: intToBool)
  final bool? isSelected;

  @override
  List<Object?> get props => [id, title, description, dateTime, isSelected];

  @override
  TodoModel fromJson(Map<String, Object?> json) => TodoModel.fromJson(json);

  @override
  Map<String, Object?> toJson() => _$TodoModelToJson(this);

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dateTime,
    bool? isSelected,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
