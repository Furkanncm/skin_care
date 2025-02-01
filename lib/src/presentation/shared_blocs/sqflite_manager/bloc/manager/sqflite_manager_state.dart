part of 'sqflite_manager_bloc.dart';

sealed class SqfliteManagerState {
  const SqfliteManagerState({
    this.baseResult,
  });

  final BaseResult<dynamic>? baseResult;
}

final class SqfliteManagerInitial extends SqfliteManagerState {}

final class SqfliteManagerSuccess extends SqfliteManagerState {
  const SqfliteManagerSuccess({required super.baseResult});
}

final class SqfliteManagerError extends SqfliteManagerState {
  const SqfliteManagerError({required super.baseResult});
}
