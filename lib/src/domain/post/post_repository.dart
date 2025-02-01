import 'dart:async';

import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/post_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/post/request/post_command.dart';
import 'package:bloc_clean_architecture/src/data/model/post/response/post.dart';
import 'package:injectable/injectable.dart';

mixin IPostRepository {
  Future<BaseResponse<List<Post>>> getPosts(PostCommand command);
}

@lazySingleton
final class PostRepository implements IPostRepository {
  PostRepository(this._postRemoteDS);

  final PostRemoteDS _postRemoteDS;

  @override
  Future<BaseResponse<List<Post>>> getPosts(PostCommand command) => _postRemoteDS.getPosts(command);
}
