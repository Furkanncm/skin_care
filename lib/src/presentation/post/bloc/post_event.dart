part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PostFetchedEvent extends PostEvent {}

final class PostRefreshedEvent extends PostEvent {}
