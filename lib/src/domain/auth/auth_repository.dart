import 'dart:async';

import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/local/auth_local_ds.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/auth_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/login/dto/login_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user_credentials/my_user_credentials.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:injectable/injectable.dart';

abstract interface class IAuthRepository {
  Future<BaseResponse<LoginDto>> login({required String username, required String password});
  Future<BaseResponse<LoginDto>> refreshToken(String refreshToken);
  Future<BaseResponse<void>> logout();
  Future<bool> setUserCredentials({required MyUserCredentials myUserCredentials});
  MyUserCredentials? getUserCredentials();
  Future<bool> deleteUserCredentials();
  void changeAuthState({required AuthState authState});
}

@lazySingleton
final class AuthRepository implements IAuthRepository {
  AuthRepository(
    this._authRemoteDS,
    this._authLocalDS,
  );

  final StreamController<AuthState> _controller = StreamController<AuthState>();

  final AuthRemoteDS _authRemoteDS;
  final AuthLocalDS _authLocalDS;

  Stream<AuthState> get status async* {
    yield* _controller.stream;
  }

  @override
  Future<BaseResponse<LoginDto>> login({required String username, required String password}) => _authRemoteDS.login(username: username, password: password);

  @override
  Future<BaseResponse<LoginDto>> refreshToken(String refreshToken) => _authRemoteDS.refreshToken(refreshToken);

  @override
  Future<BaseResponse<void>> logout() => _authRemoteDS.logout();

  @override
  @override
  @override
  Future<bool> setUserCredentials({required MyUserCredentials myUserCredentials}) => _authLocalDS.setUserCredentials(myUserCredentials: myUserCredentials);

  @override
  MyUserCredentials? getUserCredentials() => _authLocalDS.getUserCredentials();

  @override
  Future<bool> deleteUserCredentials() => _authLocalDS.deleteUserCredentials();

  @override
  void changeAuthState({required AuthState authState}) {
    _controller.add(authState);
  }

  void dispose() {
    _controller.close();
  }
}
