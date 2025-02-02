// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
// import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
// import 'package:bloc_clean_architecture/src/common/network_manager/message.dart';
// import 'package:bloc_clean_architecture/src/data/model/comment/request/comment_command.dart';
// import 'package:bloc_clean_architecture/src/data/model/comment/response/comment.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_core/flutter_core.dart';
// import 'package:injectable/injectable.dart';

// mixin ICommentRemoteDS {
//   Future<BaseResponse<List<Comment>>> getComments(CommentCommand command);
// }

// @lazySingleton
// final class CommentRemoteDS implements ICommentRemoteDS {
//   CommentRemoteDS();

//   //final NetworkManager _networkManager;

//   @override
//   Future<BaseResponse<List<Comment>>> getComments(CommentCommand command) async {
//     /* final response = await _networkManager
//         .request<List<Comment>, Comment>(
//           path: RequestPath.comments,
//           type: RequestType.get,
//           responseEntityModel: const Comment(),
//           queryParameters: command,
//         );

//     return response; */

//     /// API yerine asset'den alınıyor.
//     return getMockComments(command);
//   }
// }

// /// API yerine asset'den alınıyor.
// extension CommentRemoteDSExtension on CommentRemoteDS {
//   Future<BaseResponse<List<Comment>>> getMockComments(CommentCommand command) async {
//     await 500.milliseconds.delay<void>();
//     final data = await rootBundle.loadString(Assets.networkMocks.comments);
//     final list = jsonDecode(data) as List<dynamic>;
//     final commentList = list.map((e) => Comment.fromJson(e as Map<String, dynamic>)).where((element) => element.postId == command.postId).toList();
//     if (Random().nextInt(2) == 0) {
//       return const BaseResponse(error: SocketException('İnternet bağlantısı yok.'), messages: [], succeeded: false);
//     } else {
//       return BaseResponse(
//         data: commentList,
//         statusCode: 200,
//         messages: [
//           const Message(
//             type: MessageType.success,
//             content: 'Yorumlar başarıyla getirildi.',
//           ),
//         ],
//         succeeded: true,
//       );
//     }
//   }
// }
