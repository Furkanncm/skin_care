import 'dart:async';
import 'dart:convert';

import 'package:bloc_clean_architecture/src/common/gen/assets.gen.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/message.dart';
import 'package:bloc_clean_architecture/src/data/model/post/request/post_command.dart';
import 'package:bloc_clean_architecture/src/data/model/post/response/post.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

mixin IPostRemoteDS {
  FutureOr<BaseResponse<List<Post>>> getPosts(PostCommand command);
}

@lazySingleton
final class PostRemoteDS implements IPostRemoteDS {
  PostRemoteDS();

  //final NetworkManager _networkManager;

  @override
  Future<BaseResponse<List<Post>>> getPosts(PostCommand command) async {
    /* final response = await _networkManager
        .request<List<Post>, Post>(
          path: RequestPath.posts,
          type: RequestType.get,
          responseEntityModel: const Post(),
          queryParameters: command,
        )
        .intercept(showIndicator: true);

    return response; */

    return getMockPosts(command);
  }
}

/// API yerine asset'den alınıyor.
extension PostRemoteDSExtension on PostRemoteDS {
  Future<BaseResponse<List<Post>>> getMockPosts(PostCommand command) async {
    await 500.milliseconds.delay<void>();
    final data = await rootBundle.loadString(Assets.networkMocks.posts);
    final list = jsonDecode(data) as List<dynamic>;
    List<Post> commentList;
    try {
      commentList = list.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList().getRange(command.start ?? 0, (command.start ?? 0) + (command.limit ?? 0)).toList();
    } catch (e) {
      commentList = [];
    }
    return BaseResponse(
      data: commentList,
      statusCode: 200,
      messages: [
        const Message(type: MessageType.success, content: 'Postlar başarıyla getirildi.'),
      ],
      succeeded: true,
    );
  }
}
