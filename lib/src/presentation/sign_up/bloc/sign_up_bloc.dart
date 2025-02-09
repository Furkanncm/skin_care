import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/toasts/my_toasts.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../../../common/enums/firestore_collection.dart';
import '../../../common/localization/localization_key.dart';
import '../../../common/routing/route_paths.dart';
import '../../../common/routing/router.dart';
import '../../../data/model/my_user_credentials/my_user_credentials.dart';
import '../../../domain/auth/auth_repository.dart';
import '../../../domain/user/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._authRepository, this._userRepository) : super(SignUpState()) {
    on<SignUpInitializedEvent>(_initialize);
    on<SignUpButtonPressedEvent>(_signUpButtonPressedEvent);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  Future<void> _initialize(SignUpEvent event, Emitter<SignUpState> emit) async {
    await 300.milliseconds.delay<void>();
    emit(state.copyWith(status: SignUpStatus.success));
  }

  Future<void> _signUpButtonPressedEvent(SignUpButtonPressedEvent event, Emitter<SignUpState> emit) async {
    if (!(formKey.currentState!.validate())) return;
    final name = nameController.text;
    final surname = surnameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).withIndicator();
      final user = MyUser(name: name, surName: surname, email: email, id: userCredential.user!.uid, password: password);
      final isOk = await _userRepository.setLocalUser(user: user);
      final idToken = await userCredential.user?.getIdToken();
      final myUserCredential = MyUserCredentials(accessToken: idToken, refreshToken: idToken);
      _authRepository.setUserCredentials(myUserCredentials: myUserCredential);
      if (isOk) router.pushReplacementNamed(RoutePaths.home.name);
      _authRepository.changeAuthState(authState: AuthState.authenticated());
      await FirebaseFirestore.instance.collection(FirestoreCollection.users.value).doc(user.id).set(user.toJson());
      SCToasts.showSuccessToast(message: LocalizationKey.accountCreatedSuccess.value);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        SCToasts.showErrorToast(message: "Bu e-posta adresi zaten kullanılıyor!");
      } else {
        SCToasts.showErrorToast(message: "Bir hata oluştu: ${e.message}");
      }
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    return super.close();
  }
}
