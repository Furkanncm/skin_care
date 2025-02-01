import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/domain/sqflite_manager/sqflite_manager_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'sqflite_manager_event.dart';
part 'sqflite_manager_state.dart';

@lazySingleton
class SqfliteManagerBloc extends Bloc<SqfliteManagerEvent, SqfliteManagerState> {
  SqfliteManagerBloc(this._sqfliteManagerRepository) : super(SqfliteManagerInitial()) {
    on<_SqfliteManagerSuccessArrivedEvent>(_sqfliteManagerSuccessArrived);
    on<_SqfliteManagerErrorArrivedEvent>(_sqfliteManagerErrorArrived);

    _sqfliteManagerRepository.status.listen((state) {
      if (state is SqfliteManagerSuccess) {
        add(_SqfliteManagerSuccessArrivedEvent(state.baseResult!));
      } else if (state is SqfliteManagerError) {
        add(_SqfliteManagerErrorArrivedEvent(state.baseResult!));
      }
    });
  }

  final SqfliteManagerRepository _sqfliteManagerRepository;

  Future<void> _sqfliteManagerSuccessArrived(_SqfliteManagerSuccessArrivedEvent event, Emitter<SqfliteManagerState> emit) async {
    emit(SqfliteManagerSuccess(baseResult: event.baseResult));
  }

  Future<void> _sqfliteManagerErrorArrived(_SqfliteManagerErrorArrivedEvent event, Emitter<SqfliteManagerState> emit) async {
    emit(SqfliteManagerError(baseResult: event.baseResult));
  }
}
