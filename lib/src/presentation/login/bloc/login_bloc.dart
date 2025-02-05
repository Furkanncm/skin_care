import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/enums/firestore_collection.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/routing/router.dart';
import 'package:bloc_clean_architecture/src/common/toasts/my_toasts.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user_credentials/my_user_credentials.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .withIndicator();
      if (userCredential.user == null) return;
      final idToken = await userCredential.user?.getIdToken().withIndicator();
      final myUserCredential = MyUserCredentials(accessToken: idToken, refreshToken: idToken);
      final doc = await FirebaseFirestore.instance.collection(FirestoreCollection.users.value).doc(userCredential.user?.uid).get().withIndicator();
      if (!(doc.exists)) return;
      final user = MyUser.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      _authRepository.setUserCredentials(myUserCredentials: myUserCredential);
      _userRepository.setLocalUser(user: MyUser(name: user.name, surName: user.surName, email: email, password: password, id: user.id));
      _authRepository.changeAuthState(authState: AuthState.authenticated());
      SCToasts.showSuccessToast(message: LocalizationKey.sloganForLogin.value);
      router.pushReplacementNamed(RoutePaths.home.name);
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
