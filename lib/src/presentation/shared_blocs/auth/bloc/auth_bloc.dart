import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user_credentials/my_user_credentials.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthState.unknown()) {
    on<_AuthStateChangedEvent>(_authStateChanged);

    _authRepository.status.listen((state) {
      add(_AuthStateChangedEvent(state));
    });
  }

  final AuthRepository _authRepository;

  void _authStateChanged(_AuthStateChangedEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        status: event.authState.status,
        user: event.authState.user,
        userCredentials: event.authState.userCredentials,
      ),
    );
  }
}
