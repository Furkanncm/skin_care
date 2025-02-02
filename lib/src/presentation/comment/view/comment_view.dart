// import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
// import 'package:bloc_clean_architecture/src/data/model/post/response/post.dart';
// import 'package:bloc_clean_architecture/src/presentation/comment/bloc/comment_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CommentView extends StatelessWidget {
//   const CommentView({required this.post, super.key});

//   final Post post;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<CommentBloc>()..add(CommentFetchedEvent(post)),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Comment')),
//         body: const _Body(),
//       ),
//     );
//   }
// }

// class _Body extends StatelessWidget {
//   const _Body();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CommentBloc, CommentState>(
//       builder: (context, state) {
//         return switch (state.status) {
//           CommentStatus.initial => const Center(child: CircularProgressIndicator()),
//           CommentStatus.success => _ListView(state: state),
//           CommentStatus.failure => const Center(child: Text('Failed to fetch comments')),
//         };
//       },
//     );
//   }
// }

// class _ListView extends StatelessWidget {
//   const _ListView({required this.state});

//   final CommentState state;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: state.comments.length,
//       itemBuilder: (context, index) {
//         final comment = state.comments[index];
//         return Card(
//           child: ListTile(
//             leading: const Icon(Icons.comment),
//             title: Text(comment.email ?? ''),
//             subtitle: Text(comment.body ?? ''),
//           ),
//         );
//       },
//     );
//   }
// }
