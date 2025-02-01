import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/data/model/post/response/post.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          context.goNamed(RoutePaths.comment.asRoutePath, extra: post);
        },
        title: Text(post.title ?? ''),
        subtitle: Text(post.body ?? ''),
      ),
    );
  }
}
