// import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
// import 'package:bloc_clean_architecture/src/presentation/post/bloc/post_bloc.dart';
// import 'package:bloc_clean_architecture/src/presentation/post/widgets/post_list_view.dart';
// import 'package:bloc_clean_architecture/src/presentation/post/widgets/posts_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PostView extends StatelessWidget {
//   const PostView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<PostBloc>()..add(PostFetchedEvent()),
//       child: const Scaffold(
//         appBar: PostsAppBar(),
//         body: PostsListView(),
//       ),
//     );
//   }
// }
