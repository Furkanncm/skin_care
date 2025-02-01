part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class TodoInitializedEvent extends TodoEvent {}

final class TodoSearchTriggeredEvent extends TodoEvent {
  const TodoSearchTriggeredEvent(this.keyword);

  final String keyword;

  @override
  List<Object> get props => [keyword];
}

final class TodoCheckboxClickedEvent extends TodoEvent {
  const TodoCheckboxClickedEvent(this.todo);

  final TodoModel todo;

  @override
  List<Object> get props => [todo];
}

final class TodoDeleteClickedEvent extends TodoEvent {
  const TodoDeleteClickedEvent(this.todo);

  final TodoModel todo;

  @override
  List<Object> get props => [todo];
}

final class TodoAddClickedEvent extends TodoEvent {
  const TodoAddClickedEvent(this.todo);

  final TodoModel todo;

  @override
  List<Object> get props => [todo];
}
