part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashError extends SplashState {
  const SplashError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
