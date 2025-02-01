part of 'comment_bloc.dart';

enum CommentStatus { initial, success, failure }

class CommentState extends Equatable {
  const CommentState({
    this.status = CommentStatus.initial,
    this.comments = const <Comment>[],
  });

  final CommentStatus status;
  final List<Comment> comments;

  CommentState copyWith({
    CommentStatus? status,
    List<Comment>? comments,
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object> get props => [status, comments];
}
