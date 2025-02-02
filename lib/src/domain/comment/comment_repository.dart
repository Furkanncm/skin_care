// import 'dart:async';

// import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
// import 'package:bloc_clean_architecture/src/data/data_source/remote/comment_remote_ds.dart';
// import 'package:bloc_clean_architecture/src/data/model/comment/request/comment_command.dart';
// import 'package:bloc_clean_architecture/src/data/model/comment/response/comment.dart';
// import 'package:injectable/injectable.dart';

// mixin ICommentRepository {
//   Future<BaseResponse<List<Comment>>> getComments(CommentCommand command);
// }

// @lazySingleton
// final class CommentRepository implements ICommentRepository {
//   CommentRepository(this._commentRemoteDS);

//   final CommentRemoteDS _commentRemoteDS;

//   @override
//   Future<BaseResponse<List<Comment>>> getComments(CommentCommand command) => _commentRemoteDS.getComments(command);
// }
