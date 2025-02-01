import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/message.dart';
import 'package:bloc_clean_architecture/src/data/model/login/dto/login_dto.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

mixin IAuthRemoteDS {
  Future<BaseResponse<LoginDto>> login({required String username, required String password});
  Future<BaseResponse<LoginDto>> refreshToken(String refreshToken);
  Future<BaseResponse<void>> logout();
}

@lazySingleton
final class AuthRemoteDS implements IAuthRemoteDS {
  const AuthRemoteDS(/* this._networkManager */);

  //final NetworkManager _networkManager;

  @override
  Future<BaseResponse<LoginDto>> login({required String username, required String password}) async {
    /* return _networkManager.request<LoginResponseModel, LoginResponseModel>(
      path: RequestPath.login,
      type: RequestType.post,
      hasBaseResponse: false,
      headers: {
        'Content-Type': Headers.formUrlEncodedContentType,
        'Authorization': Env.authorization,
      },
      data: LoginRequestModel(
        username: username,
        password: password,
        grantType: Env.grantType,
        clientId: 'angular-client',
      ),
      responseEntityModel: const LoginResponseModel(),
    ); */

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(500.milliseconds);
    return BaseResponse(
      data: LoginDto(
        accessToken: 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkE1MDI1MjhBMkRCRjg5NEU5NDhENzU5RjE3MDA1NjlBQkRFNUI4QkJSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6InBRSlNpaTJfaVU2VWpYV2ZGd0JXbXIzbHVMcyJ9.eyJuYmYiOjE3MjIzNDQzNzgsImV4cCI6MTcyMjM2MjM3OCwiaXNzIjoiaHR0cDovLzE3Mi4yMS4xMi4xNjc6MzgwMiIsImNsaWVudF9pZCI6ImFuZ3VsYXItY2xpZW50Iiwic3ViIjoiMGY4ZmFkNWItZDljYi00NjlmLWExNjUtNzA4Njc3Mjg5NTBlIiwiYXV0aF90aW1lIjoxNzIyMzQ0Mzc4LCJpZHAiOiJsb2NhbCIsInVzZXJJZCI6IjBmOGZhZDViLWQ5Y2ItNDY5Zi1hMTY1LTcwODY3NzI4OTUwZSIsInVzZXJOYW1lIjoiYWRtaW4gbmFtZSIsImp0aSI6IkY1MkYzRDNCQjcyRjU2NUUxRTYxMzRGMkRDMUFCNzg3IiwiaWF0IjoxNzIyMzQ0Mzc4LCJzY29wZSI6WyJhcGkxIiwib3BlbmlkIiwicHJvZmlsZSIsIm9mZmxpbmVfYWNjZXNzIl0sImFtciI6WyJwd2QiXX0.UJ4ZL_FK2VsGzyh_PgBD6Pz2lvRaNlNoxmhWcpRmT2fD8t-842adIfUJPTDZDWQqn8Spf0ZuOpoC3d0uduO7AjgKdnwUQljfvpMXIkyeDaqlBblA06k5XiuW2jGB00s7yLf8WqRhv0TCKmTvyeMcd0KENq5gXKjHpAH2tAdAgnk3YOkVDUKTS72Rdfdhj4xBo4r6dHbJsB20noJs48iPhUwkbB7SreBkeuX_h38rMNj2evdB5nBPm7GawWkFW6D_yoAOEei4Bx4-XT1I9rPCWxA6O9Qq9eTrUfH3b7PiK7G9PYZ-6gnMb86-VPCvGRiJc5P3_tUhgEnUd9o0MEquaA',
        refreshToken: '3ac2b275-2198-485d-9b49-091fc048a623',
        tokenType: 'Bearer',
        authTime: DateTime.now(),
        expiresIn: 18000,
        language: 'en-US',
      ),
      statusCode: 200,
      messages: [
        const Message(type: MessageType.success, content: 'Giriş başarılı.'),
      ],
      succeeded: true,
    );
  }

  @override
  Future<BaseResponse<LoginDto>> refreshToken(String refreshToken) async {
    /* return _networkManager.request<LoginResponseModel, LoginResponseModel>(
      path: RequestPath.login,
      type: RequestType.post,
      hasBaseResponse: false,
      headers: {
        'Content-Type': Headers.formUrlEncodedContentType,
        'Authorization': Env.authorization,
      },
      responseEntityModel: const LoginResponseModel(),
      data: RefreshTokenRequestModel(refreshToken: refreshToken, grantType: 'refresh_token'),
    ); */

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(500.milliseconds);
    return BaseResponse(
      data: LoginDto(
        accessToken: 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkE1MDI1MjhBMkRCRjg5NEU5NDhENzU5RjE3MDA1NjlBQkRFNUI4QkJSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6InBRSlNpaTJfaVU2VWpYV2ZGd0JXbXIzbHVMcyJ9.eyJuYmYiOjE3MjIzNDQzNzgsImV4cCI6MTcyMjM2MjM3OCwiaXNzIjoiaHR0cDovLzE3Mi4yMS4xMi4xNjc6MzgwMiIsImNsaWVudF9pZCI6ImFuZ3VsYXItY2xpZW50Iiwic3ViIjoiMGY4ZmFkNWItZDljYi00NjlmLWExNjUtNzA4Njc3Mjg5NTBlIiwiYXV0aF90aW1lIjoxNzIyMzQ0Mzc4LCJpZHAiOiJsb2NhbCIsInVzZXJJZCI6IjBmOGZhZDViLWQ5Y2ItNDY5Zi1hMTY1LTcwODY3NzI4OTUwZSIsInVzZXJOYW1lIjoiYWRtaW4gbmFtZSIsImp0aSI6IkY1MkYzRDNCQjcyRjU2NUUxRTYxMzRGMkRDMUFCNzg3IiwiaWF0IjoxNzIyMzQ0Mzc4LCJzY29wZSI6WyJhcGkxIiwib3BlbmlkIiwicHJvZmlsZSIsIm9mZmxpbmVfYWNjZXNzIl0sImFtciI6WyJwd2QiXX0.UJ4ZL_FK2VsGzyh_PgBD6Pz2lvRaNlNoxmhWcpRmT2fD8t-842adIfUJPTDZDWQqn8Spf0ZuOpoC3d0uduO7AjgKdnwUQljfvpMXIkyeDaqlBblA06k5XiuW2jGB00s7yLf8WqRhv0TCKmTvyeMcd0KENq5gXKjHpAH2tAdAgnk3YOkVDUKTS72Rdfdhj4xBo4r6dHbJsB20noJs48iPhUwkbB7SreBkeuX_h38rMNj2evdB5nBPm7GawWkFW6D_yoAOEei4Bx4-XT1I9rPCWxA6O9Qq9eTrUfH3b7PiK7G9PYZ-6gnMb86-VPCvGRiJc5P3_tUhgEnUd9o0MEquaA',
        refreshToken: '3ac2b275-2198-485d-9b49-091fc048a623',
        tokenType: 'Bearer',
        authTime: DateTime.now(),
        expiresIn: 18000,
        language: 'en-US',
      ),
      statusCode: 200,
      messages: [
        const Message(type: MessageType.success, content: 'Giriş başarılı.'),
      ],
      succeeded: true,
    );
  }

  @override
  Future<BaseResponse<void>> logout() async {
    /* return _networkManager.request<EmptyObject, EmptyObject>(
      path: RequestPath.logout,
      type: RequestType.post,
      responseEntityModel: const EmptyObject(),
    ); */

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(500.milliseconds);
    return const BaseResponse(
      statusCode: 200,
      messages: [
        Message(type: MessageType.success, content: 'Çıkış başarılı.'),
      ],
      succeeded: true,
    );
  }
}
