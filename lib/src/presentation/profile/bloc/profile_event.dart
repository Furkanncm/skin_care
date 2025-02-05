part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileEventInitialize extends ProfileEvent {
  const ProfileEventInitialize();
}

final class ProfileLogOutEvent extends ProfileEvent {
  const ProfileLogOutEvent();
}