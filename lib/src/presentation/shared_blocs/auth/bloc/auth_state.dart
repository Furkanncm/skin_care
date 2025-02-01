part of 'auth_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unAuthenticated }

class AuthState extends Equatable {
  const AuthState._({required this.status, required this.user, required this.userCredentials});

  const AuthState.unknown() : this._(status: AuthenticationStatus.unknown, user: null, userCredentials: null);
  const AuthState.unAuthenticated() : this._(status: AuthenticationStatus.unAuthenticated, user: null, userCredentials: null);
  const AuthState.authenticated({MyUser? user, MyUserCredentials? userCredentials}) : this._(status: AuthenticationStatus.authenticated, user: user, userCredentials: userCredentials);

  final AuthenticationStatus status;
  final MyUser? user;
  final MyUserCredentials? userCredentials;

  @override
  List<Object?> get props => [status, user, userCredentials];

  AuthState copyWith({AuthenticationStatus? status, MyUser? user, MyUserCredentials? userCredentials}) {
    return AuthState._(
      status: status ?? this.status,
      user: user ?? this.user,
      userCredentials: userCredentials ?? this.userCredentials,
    );
  }
}
