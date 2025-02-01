part of 'sqflite_manager_bloc.dart';

sealed class SqfliteManagerEvent extends Equatable {
  const SqfliteManagerEvent();

  @override
  List<Object> get props => [];
}

class _SqfliteManagerSuccessArrivedEvent extends SqfliteManagerEvent {
  const _SqfliteManagerSuccessArrivedEvent(this.baseResult);
  final BaseResult<dynamic> baseResult;

  @override
  List<Object> get props => [baseResult];
}

class _SqfliteManagerErrorArrivedEvent extends SqfliteManagerEvent {
  const _SqfliteManagerErrorArrivedEvent(this.baseResult);
  final BaseResult<dynamic> baseResult;

  @override
  List<Object> get props => [baseResult];
}
