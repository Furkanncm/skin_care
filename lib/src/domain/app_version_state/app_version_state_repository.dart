import 'dart:async';

import 'package:bloc_clean_architecture/src/common/cubits/version_control/cubit/version_control_cubit.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/enums/app_platform.dart';
import 'package:bloc_clean_architecture/src/data/model/version_control/response/version_control.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

mixin IAppVersionStateRepository {
  Future<BaseResponse<VersionControl>> appVersionState({required AppPlatform appPlatform, required String appVersion});
}

@lazySingleton
final class AppVersionStateRepository implements IAppVersionStateRepository {
  AppVersionStateRepository();

  final StreamController<VersionControlState> _controller = StreamController<VersionControlState>();

  Stream<VersionControlState> get status async* {
    yield* _controller.stream;
  }

  @override
  Future<BaseResponse<VersionControl>> appVersionState({required AppPlatform appPlatform, required String appVersion}) async {
    const response = BaseResponse(
      data: VersionControl(
        newVersionAvailable: true,
        forceUpdate: false,
        title: 'New Version Available',
        content: 'Please update to the latest version',
        version: '1.0.1',
        url: 'https://www.google.com',
      ),
    );

    final data = response.data;

    if ((data!.newVersionAvailable ?? false) && data.forceUpdate == false && data.version.isNotNull) {
      _controller.add(VersionControlOptionalUpdateAvailable(data.version!));
    }
    return response;
  }

  void dispose() {
    _controller.close();
  }
}
