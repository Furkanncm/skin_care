import 'package:bloc_clean_architecture/src/common/sqflite_manager/sqflite_manager.dart';
import 'package:bloc_clean_architecture/src/common/sqflite_manager/tables/todo_table.dart';
import 'package:bloc_clean_architecture/src/data/model/todo_model/response/todo_model.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ITodoLocalDS {
  Future<BaseResult<List<TodoModel>>> getTodos(String search);
  Future<BaseResult<TodoModel>> addTodo(TodoModel todo);
  Future<BaseResult<int>> updateTodo(TodoModel todo);
  Future<BaseResult<int>> deleteTodo(TodoModel todo);
  Future<BaseResult<int>> deleteAll();
}

@lazySingleton
final class TodoLocalDS implements ITodoLocalDS {
  const TodoLocalDS(this._sqflite);

  final SqfliteManager _sqflite;

  @override
  Future<BaseResult<List<TodoModel>>> getTodos(String search) async {
    return _sqflite.querySerializable(
      TodoTable.tableName,
      const TodoModel(),
      where: '${TodoTable.titleFieldName} like ?',
      whereArgs: ['%$search%'],
    );
  }

  @override
  Future<BaseResult<TodoModel>> addTodo(TodoModel todo) async {
    return _sqflite.transaction((txn) async {
      await txn.insert(TodoTable.tableName, todo.toJson());
      final query = await txn.querySerializable(TodoTable.tableName, const TodoModel(), orderBy: '${TodoTable.idFieldName} desc', limit: 1);
      return query.first;
    });
  }

  @override
  Future<BaseResult<int>> deleteTodo(TodoModel todo) async {
    return _sqflite.delete(
      TodoTable.tableName,
      where: '${TodoTable.idFieldName} = ?',
      whereArgs: [todo.id],
    );
  }

  @override
  Future<BaseResult<int>> updateTodo(TodoModel todo) async {
    return _sqflite.update(
      TodoTable.tableName,
      todo.toJson(),
      where: '${TodoTable.idFieldName} = ?',
      whereArgs: [todo.id],
    );
  }

  @override
  Future<BaseResult<int>> deleteAll() async {
    return _sqflite.delete(TodoTable.tableName);
  }
}
