import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user_credentials/my_user_credentials.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
    this._authRepository,
    this._userRepository,
  ) : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(_loginButtonPressed);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> _loginButtonPressed(LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    final loginResponse = await _authRepository.login(username: 'username', password: 'password').withIndicator();

    if (loginResponse.data.isNull) return;
    if (loginResponse.data!.accessToken.isNull || loginResponse.data!.refreshToken.isNull) throw Exception('Access token or refresh token is null');
    final userCredentials = MyUserCredentials(accessToken: loginResponse.data!.accessToken, refreshToken: loginResponse.data!.refreshToken);
    await _authRepository.setUserCredentials(myUserCredentials: userCredentials);

    final userResponse = await _userRepository.getRemoteUser().withIndicator().intercept();
    final user = userResponse.data;
    if (user.isNull) return;
    await _userRepository.setLocalUser(user: user!);
    _authRepository.changeAuthState(authState: AuthState.authenticated(user: user, userCredentials: userCredentials));
    if (user.id.isNull) throw Exception('LoginBloc: User id is null');
  }
}
