// import 'package:bloc/bloc.dart';
// import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
// import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
// import 'package:bloc_clean_architecture/src/data/model/comment/request/comment_command.dart';
// import 'package:bloc_clean_architecture/src/data/model/comment/response/comment.dart';
// import 'package:bloc_clean_architecture/src/data/model/post/response/post.dart';
// import 'package:bloc_clean_architecture/src/domain/comment/comment_repository.dart';
// import 'package:equatable/equatable.dart';
// import 'package:injectable/injectable.dart';

// part 'comment_event.dart';
// part 'comment_state.dart';

// @injectable
// class CommentBloc extends Bloc<CommentEvent, CommentState> {
//   CommentBloc(this._commentRepository) : super(const CommentState()) {
//     on<CommentFetchedEvent>(commentFetched);
//   }

//   // final CommentRepository _commentRepository;

//   Future<void> commentFetched(CommentFetchedEvent event, Emitter<CommentState> emit) async {
//     try {
//       final response = await _commentRepository.getComments(CommentCommand(postId: event.post.id)).intercept().withIndicator();
//       if (response.data == null) throw Exception('Error fetching posts');

//       return emit(
//         state.copyWith(
//           status: CommentStatus.success,
//           comments: response.data,
//         ),
//       );
//     } catch (_) {
//       emit(state.copyWith(status: CommentStatus.failure));
//     }
//   }
// }
