part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressedEvent extends LoginEvent {
  const LoginButtonPressedEvent();

  @override
  List<Object> get props => [];
}
