part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}
final class SignUpInitializedEvent extends SignUpEvent {}

final class SignUpButtonPressedEvent extends SignUpEvent {}