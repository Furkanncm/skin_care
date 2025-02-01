import 'package:bloc_clean_architecture/src/presentation/post/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Post'),
      actions: [
        IconButton(onPressed: () => refreshButtonClick(context), icon: const Icon(Icons.refresh)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void refreshButtonClick(BuildContext context) {
    context.read<PostBloc>().add(PostRefreshedEvent());
  }
}
