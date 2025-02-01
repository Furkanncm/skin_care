import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/exceptions/splash_exception.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/enums/app_platform.dart';
import 'package:bloc_clean_architecture/src/data/model/version_control/response/version_control.dart';
import 'package:bloc_clean_architecture/src/domain/app_version_state/app_version_state_repository.dart';
import 'package:flutter_core/flutter_core.dart';

final class VersionControlRetriable extends Retriable<BaseResponse<VersionControl>> {
  VersionControlRetriable({super.maxRetries, super.delayMultiplier});

  AppVersionStateRepository get _appVersionStateRepository => getIt<AppVersionStateRepository>();

  @override
  Future<BaseResponse<VersionControl>> retryCallback() async {
    final response = await _appVersionStateRepository.appVersionState(appPlatform: AppPlatform.ios, appVersion: '1.0.0');
    if (response.data.isNull) throw SplashException(response.error.toString());

    return response;
  }
}
