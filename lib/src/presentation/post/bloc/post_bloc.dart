// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:bloc_clean_architecture/src/data/model/post/request/post_command.dart';
// import 'package:bloc_clean_architecture/src/data/model/post/response/post.dart';
// import 'package:bloc_clean_architecture/src/domain/post/post_repository.dart';
// import 'package:bloc_concurrency/bloc_concurrency.dart';
// import 'package:equatable/equatable.dart';
// import 'package:injectable/injectable.dart';
// import 'package:stream_transform/stream_transform.dart';

// part 'post_event.dart';
// part 'post_state.dart';

// const _postLimit = 20;
// const throttleDuration = Duration(milliseconds: 100);

// EventTransformer<E> throttleDroppable<E>(Duration duration) {
//   return (events, mapper) {
//     return droppable<E>().call(events.throttle(duration), mapper);
//   };
// }

// @injectable
// class PostBloc extends Bloc<PostEvent, PostState> {
//   PostBloc(this._postRepository) : super(const PostState()) {
//     on<PostFetchedEvent>(_postFetched, transformer: throttleDroppable(throttleDuration));
//     on<PostRefreshedEvent>(_postRefreshed, transformer: throttleDroppable(throttleDuration));
//   }

//   final PostRepository _postRepository;

//   Future<void> _postFetched(PostFetchedEvent event, Emitter<PostState> emit) async {
//     if (state.hasReachedMax) return;

//     try {
//       if (state.status == PostStatus.initial) {
//         final response = await _postRepository.getPosts(const PostCommand(start: 0, limit: _postLimit));
//         if (response.data == null) throw Exception('Error fetching posts');
//         return emit(
//           state.copyWith(
//             status: PostStatus.success,
//             posts: response.data,
//             hasReachedMax: false,
//           ),
//         );
//       }
//       final response = await _postRepository.getPosts(PostCommand(start: state.posts.length, limit: _postLimit));
//       if (response.data == null) throw Exception('Error fetching posts');

//       response.data!.isEmpty
//           ? emit(state.copyWith(hasReachedMax: true))
//           : emit(
//               state.copyWith(
//                 status: PostStatus.success,
//                 posts: List.of(state.posts)..addAll(response.data!),
//                 hasReachedMax: false,
//               ),
//             );
//     } catch (_) {
//       emit(state.copyWith(status: PostStatus.failure));
//     }
//   }

//   Future<void> _postRefreshed(PostRefreshedEvent event, Emitter<PostState> emit) async {
//     try {
//       final response = await _postRepository.getPosts(const PostCommand(start: 0, limit: _postLimit));
//       if (response.data == null) throw Exception('Error fetching posts');
//       return emit(
//         state.copyWith(
//           status: PostStatus.success,
//           posts: response.data,
//           hasReachedMax: false,
//         ),
//       );
//     } catch (_) {
//       emit(state.copyWith(status: PostStatus.failure));
//     }
//   }
// }
