import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/interceptors/dio_network_log_interceptor.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/message.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/refresh_token_interceptor.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/request_path.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/domain/service_unavailable/service_unavailable_repository.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

typedef ValidateStatus = bool Function(int? statusCode);

@lazySingleton
final class NetworkManager extends CoreNetworkManager {
  NetworkManager()
      : super(
          baseOptions: BaseOptions(
            baseUrl: AppConstants.networkConstants.baseUrl,
          ),
          interceptors: [
            DioNetworkErrorLogInterceptor(),
            // DioFirebasePerformanceInterceptor(),
            RefreshTokenInterceptor(),
          ],
        );

  AuthRepository get _authRepository => getIt<AuthRepository>();
  UserRepository get _userRepository => getIt<UserRepository>();
  ServiceUnavailableRepository get _serviceUnavailableRepository => getIt<ServiceUnavailableRepository>();

  @override
  Future<CoreBaseResponse> request<T, M extends BaseModel<dynamic>>({
    required BaseRequestPath path,
    required RequestType type,
    required M responseEntityModel,
    bool hasBaseResponse = true,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? pathSuffix,
    String? contentType,
    ResponseType? responseType,
    CancelToken? cancelToken,
    ValidateStatus? validateStatus,
    Duration connectionTimeout = const Duration(seconds: 25),
    Duration receiveTimeout = const Duration(seconds: 25),
    Duration sendTimeout = const Duration(seconds: 25),
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
  }) async {
    return await super.request<T, M>(
      path: path,
      type: type,
      responseEntityModel: responseEntityModel,
      hasBaseResponse: hasBaseResponse,
      data: data,
      dioFormData: dioFormData,
      queryParameters: queryParameters,
      headers: headers,
      pathSuffix: pathSuffix,
      contentType: contentType,
      responseType: responseType,
      cancelToken: cancelToken,
      connectionTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    ) as BaseResponse<T>;
  }

  @override
  Future<CoreBaseResponse> primitiveRequest<T>({
    required BaseRequestPath path,
    required RequestType type,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? pathSuffix,
    String? contentType,
    ResponseType? responseType,
    CancelToken? cancelToken,
    ValidateStatus? validateStatus,
    Duration connectionTimeout = const Duration(seconds: 25),
    Duration receiveTimeout = const Duration(seconds: 25),
    Duration sendTimeout = const Duration(seconds: 25),
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
  }) async {
    return await super.primitiveRequest<T>(
      path: path,
      type: type,
      data: data,
      dioFormData: dioFormData,
      queryParameters: queryParameters,
      headers: headers,
      pathSuffix: pathSuffix,
      contentType: contentType,
      responseType: responseType,
      cancelToken: cancelToken,
      connectionTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    ) as BaseResponse<T>;
  }

  @override
  Map<String, dynamic> generateHeaders({required BaseRequestPath path}) {
    String? token() => _authRepository.getUserCredentials()?.accessToken;

    return switch (path) {
      RequestPath.login => {},
      _ => {'Authorization': 'Bearer ${token()}'},
      /* _ => {
          'Authorization':
              'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkE1MDI1MjhBMkRCRjg5NEU5NDhENzU5RjE3MDA1NjlBQkRFNUI4QkJSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6InBRSlNpaTJfaVU2VWpYV2ZGd0JXbXIzbHVMcyJ9.eyJuYmYiOjE3MTc0ODM4MjQsImV4cCI6MTcxNzUwMTgyNCwiaXNzIjoiaHR0cDovLzE3Mi4yMS4xMi4xNjc6MzgwMiIsImNsaWVudF9pZCI6ImFuZ3VsYXItY2xpZW50Iiwic3ViIjoiODliYzJkNWEtNDU3Zi00Y2ZhLTg0MzctNGUzMzQzZGU5YTQwIiwiYXV0aF90aW1lIjoxNzE3NDgzODI0LCJpZHAiOiJsb2NhbCIsInVzZXJJZCI6Ijg5YmMyZDVhLTQ1N2YtNGNmYS04NDM3LTRlMzM0M2RlOWE0MCIsInVzZXJOYW1lIjoiS29yYXkiLCJqdGkiOiJBMkI0OTY1RjE4Q0M5QUM4QkZENkY1QjQxNzE3NTM1QiIsImlhdCI6MTcxNzQ4MzgyNCwic2NvcGUiOlsiYXBpMSIsIm9wZW5pZCIsInByb2ZpbGUiLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicHdkIl19.lfIXlLxpEiizVeVM0koZQipYELi9f0v4CRoPOdqL16wGcOUk3xI_hCX8-GnIwc1aLmCQScja8uwqDDtYjPY4QbaOI4AAiqY42ChUGoCer_o4PGvDW1GLsi4FG1uFI8xhy_GZiW8iF9Qvy0rBwjZEYmogYhSUg1AKwjkF_ud2vbl96gKW4pZz-9z4rZrp0SvuAwwjv2ywjzgiIuQrg1XGtVoJxed53TM1ro5imtMwhA3PKHct6mN1Rlq_IJleWZwdyCFYWuWtAK6BYzgy7aemIRvUrt-2MWG8Mk2qqcd2igpxNKmC3gwiUj3yuhHMd8cCtRFe4zWdjYNm99BHGT2DCA',
        } */
    };
  }

  @override
  void onUnauthorized(DioException error) {
    if (error.requestOptions.path != RequestPath.login.asString) {
      _userRepository.deleteLocalUser();
      _authRepository
        ..deleteUserCredentials()
        ..changeAuthState(authState: const AuthState.unAuthenticated());
    }
  }

  @override
  void onServiceUnavailable(DioException error) => _serviceUnavailableRepository.onServiceUnavailable();

  @override
  BaseResponse<T> getSuccessPrimitiveResponse<T>({required Response<T> response}) => BaseResponse(data: response.data, succeeded: true, statusCode: response.statusCode);

  @override
  BaseResponse<T> getSuccessResponse<T, M extends BaseModel<dynamic>>({required Response<Map<String, dynamic>> response, required M responseEntityModel, required bool hasBaseResponse}) {
    late dynamic json;
    if (hasBaseResponse) {
      json = response.data?['data'];
    } else {
      json = response.data;
    }

    T? data;

    if (json is List<dynamic>) {
      data = json.map((e) => responseEntityModel.fromJson(e as Map<String, dynamic>)).toList().cast<M>() as T;
    } else if (json is Map<String, dynamic>) {
      data = responseEntityModel.fromJson(json) as T;
    }

    final succeeded = response.data?['succeeded'] as bool?;
    final messagesList = response.data?['messages'] as List?;
    List<Message>? messages;
    if (messagesList.isNotNullAndNotEmpty) {
      messages = messagesList!.cast<Map<String, dynamic>>().map((e) => Message(type: MessageType.fromString(e['type'] as String?), content: e['content'] as String?)).toList();
    }
    final statusCode = response.statusCode;

    return BaseResponse<T>(data: data, succeeded: succeeded, messages: messages, statusCode: statusCode);
  }

  @override
  BaseResponse<T> getErrorResponse<T>({required Object error}) {
    final statusCode = error is DioException ? error.response?.statusCode : null;
    List<dynamic>? messagesList;
    if (error is DioException && error.response?.data is Map<String, dynamic>) {
      messagesList = (error.response?.data as Map<String, dynamic>)['messages'] as List?;
    }
    final messages = messagesList?.cast<Map<String, dynamic>>().map((e) => Message(type: MessageType.fromString(e['type'] as String?), content: e['content'] as String?)).toList();

    return BaseResponse<T>(statusCode: statusCode, error: error, messages: messages);
  }
}
