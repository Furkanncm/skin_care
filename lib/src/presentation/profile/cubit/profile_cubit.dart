import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._authRepository,
    this._userRepository,
  ) : super(ProfileLoading());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> initialize() async {
    await 300.milliseconds.delay<void>();
    emit(ProfileSuccess());
  }

  Future<void> logout() async {
    final logoutResponse = await _authRepository.logout().intercept().withIndicator();
    if (!(logoutResponse.succeeded ?? false)) return;
    _authRepository.changeAuthState(authState: const AuthState.unAuthenticated());
    unawaited(_userRepository.deleteLocalUser());
    unawaited(_authRepository.deleteUserCredentials());
  }
}
