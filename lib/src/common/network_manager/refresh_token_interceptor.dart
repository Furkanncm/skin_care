import 'dart:async';

import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user_credentials/my_user_credentials.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:flutter_core/flutter_core.dart';

class RefreshTokenInterceptor extends InterceptorsWrapper {
  RefreshTokenInterceptor();

  NetworkManager get networkManager => getIt<NetworkManager>();
  AuthRepository get authRepository => getIt<AuthRepository>();

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && (err.requestOptions.data == null || (err.requestOptions.data is Map<String, dynamic> && (err.requestOptions.data as Map<String, dynamic>)['grant_type'] != 'refresh_token'))) {
      final newAccessToken = await newAccessTokenCallback();
      if (newAccessToken.isNotNull) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        return handler.resolve(await Dio(networkManager.baseOptions).fetch(err.requestOptions));
      }
    }

    return handler.next(err);
  }

  Future<String?> newAccessTokenCallback() async {
    final refreshToken = authRepository.getUserCredentials()?.refreshToken;
    if (refreshToken.isNull) return null;
    final response = await authRepository.refreshToken(refreshToken!);
    if (response.data.isNull) return null;
    await authRepository.setUserCredentials(
      myUserCredentials: MyUserCredentials(accessToken: response.data!.accessToken, refreshToken: response.data!.refreshToken),
    );

    return response.data?.accessToken;
  }
}
