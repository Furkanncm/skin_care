part of 'todo_bloc.dart';

enum TodoStatus { loading, success, error }

final class TodoState extends Equatable {
  const TodoState({this.status = TodoStatus.loading, this.todos = const [], this.errorMessage = ''});

  final TodoStatus status;
  final List<TodoModel> todos;
  final String errorMessage;

  @override
  List<Object> get props => [status, todos, errorMessage];

  TodoState copyWith({
    TodoStatus? status,
    List<TodoModel>? todos,
    String? errorMessage,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
