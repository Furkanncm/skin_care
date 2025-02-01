import 'package:bloc_clean_architecture/src/data/data_source/local/todo_local_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/todo_model/response/todo_model.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ITodoRepository {
  Future<BaseResult<List<TodoModel>>> getTodos(String search);
  Future<BaseResult<TodoModel>> addTodo(TodoModel todo);
  Future<BaseResult<int>> updateTodo(TodoModel todo);
  Future<BaseResult<int>> deleteTodo(TodoModel todo);
  Future<BaseResult<int>> deleteAll();
}

@lazySingleton
final class TodoRepository implements ITodoRepository {
  const TodoRepository(this._todoLocalDS);
  final TodoLocalDS _todoLocalDS;

  @override
  Future<BaseResult<List<TodoModel>>> getTodos(String search) async {
    return _todoLocalDS.getTodos(search);
  }

  @override
  Future<BaseResult<TodoModel>> addTodo(TodoModel todo) async {
    return _todoLocalDS.addTodo(todo);
  }

  @override
  Future<BaseResult<int>> deleteTodo(TodoModel todo) async {
    return _todoLocalDS.deleteTodo(todo);
  }

  @override
  Future<BaseResult<int>> updateTodo(TodoModel todo) async {
    return _todoLocalDS.updateTodo(todo);
  }

  @override
  Future<BaseResult<int>> deleteAll() async {
    return _todoLocalDS.deleteAll();
  }
}
