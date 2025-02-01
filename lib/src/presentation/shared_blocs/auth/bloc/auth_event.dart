part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

@immutable
final class _AuthStateChangedEvent extends AuthEvent {
  const _AuthStateChangedEvent(this.authState);

  final AuthState authState;

  @override
  List<Object> get props => [authState];
}
