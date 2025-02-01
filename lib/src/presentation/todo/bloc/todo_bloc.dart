import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/todo_model/response/todo_model.dart';
import 'package:bloc_clean_architecture/src/domain/todo/todo_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'todo_event.dart';
part 'todo_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(this._todoRepository) : super(const TodoState()) {
    on<TodoInitializedEvent>(_getTodos, transformer: debounce(Durations.medium2));
    on<TodoSearchTriggeredEvent>(_getTodos, transformer: debounce(Durations.medium2));
    on<TodoCheckboxClickedEvent>(_todoCheckboxClicked);
    on<TodoDeleteClickedEvent>(_todoDeleteClicked);
    on<TodoAddClickedEvent>(_todoAddClicked);
  }

  final TodoRepository _todoRepository;

  Future<void> _getTodos(TodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));
    final keyword = event is TodoSearchTriggeredEvent ? event.keyword : '';
    final baseResult = await _todoRepository.getTodos(keyword).withIndicator();
    if (baseResult.error != null) {
      emit(state.copyWith(status: TodoStatus.error, errorMessage: baseResult.error?.toString() ?? 'Failed to fetch todos'));
    } else {
      emit(state.copyWith(status: TodoStatus.success, todos: baseResult.data ?? []));
    }
  }

  Future<void> _todoCheckboxClicked(TodoCheckboxClickedEvent event, Emitter<TodoState> emit) async {
    final updatedTodo = event.todo.copyWith(isSelected: !(event.todo.isSelected ?? false));
    final baseResult = await _todoRepository.updateTodo(updatedTodo);
    if (baseResult.error != null) {
      emit(state.copyWith(status: TodoStatus.error, errorMessage: baseResult.error?.toString() ?? 'Failed to fetch todos'));
    } else {
      final todoList = [...state.todos];
      final index = todoList.indexOf(todoList.firstWhere((element) => element.id == updatedTodo.id));
      todoList[index] = updatedTodo;
      emit(state.copyWith(status: TodoStatus.success, todos: todoList));
    }
  }

  Future<void> _todoDeleteClicked(TodoDeleteClickedEvent event, Emitter<TodoState> emit) async {
    final baseResult = await _todoRepository.deleteTodo(event.todo);
    if (baseResult.error != null) {
      emit(state.copyWith(status: TodoStatus.error, errorMessage: baseResult.error?.toString() ?? 'Failed to fetch todos'));
    } else {
      final todoList = [...state.todos]..removeWhere((element) => element.id == event.todo.id);
      emit(state.copyWith(status: TodoStatus.success, todos: todoList));
    }
  }

  Future<void> _todoAddClicked(TodoAddClickedEvent event, Emitter<TodoState> emit) async {
    final baseResult = await _todoRepository.addTodo(event.todo);
    if (baseResult.error != null) {
      emit(state.copyWith(status: TodoStatus.error, errorMessage: baseResult.error?.toString() ?? 'Failed to fetch todos'));
    } else {
      final todoList = [...state.todos, baseResult.data!];
      emit(state.copyWith(status: TodoStatus.success, todos: todoList));
    }
  }
}
