import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/toasts/my_toasts.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user_credentials/my_user_credentials.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _loginButtonPressed(LoginButtonPressedEvent event, Emitter<LoginState> emit) async {
    if (!(formKey.currentState!.validate())) return;
    final email = emailController.text;
    final password = passwordController.text;
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.credential == null) return;
      final myUserCredential = MyUserCredentials(accessToken: userCredential.credential!.accessToken, refreshToken: userCredential.user!.refreshToken);
      _authRepository.setUserCredentials(myUserCredentials: myUserCredential);
      _userRepository.setLocalUser(user: MyUser(email: email, password: password));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SCToasts.showErrorToast(message: "User Not Found. Please Sign Up First.");
      } else if (e.code == 'wrong-password') {
        SCToasts.showErrorToast(message: "Password is Wrong, Please try again.");
      } else {
        SCToasts.showErrorToast(message: "Something Went Wrong");
      }
    }
  }
}
