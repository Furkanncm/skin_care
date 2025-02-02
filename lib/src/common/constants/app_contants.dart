import 'package:bloc_clean_architecture/src/common/constants/env.dart';
import 'package:bloc_clean_architecture/src/common/enums/build_type.dart';
import 'package:flutter/material.dart';

abstract class AppConstants {
  static const networkConstants = NetworkConstants._();
  static const configuration = Configuration._();
  static const paddingConstants = PaddingConstants._();
}

@immutable
final class Configuration {
  const Configuration._();

  BuildType get buildType => BuildType.dev;

  ApplicationConfiguration get applicationConfiguration {
    return switch (buildType) {
      BuildType.dev => const ApplicationConfiguration(
          androidPackageName: 'com.corewish.temp',
          iosLaunchIntune: true,
        ),
      BuildType.prod => const ApplicationConfiguration(
          androidPackageName: 'com.corewish.temp',
          iosLaunchIntune: true,
        ),
    };
  }
}

@immutable
final class NetworkConstants {
  const NetworkConstants._();

  String get baseUrl => AppConstants.configuration.buildType == BuildType.dev ? Env.gatewayUrlDev : Env.gatewayUrlProd;
}

@immutable
final class PaddingConstants {
  const PaddingConstants._();
  EdgeInsetsGeometry get pagePadding => const EdgeInsets.symmetric(horizontal: 23, vertical: 12);
    EdgeInsetsGeometry get pageLowPadding => const EdgeInsets.symmetric(horizontal: 15, vertical: 8);
  EdgeInsetsGeometry get horizontalPadding => const EdgeInsets.symmetric(horizontal: 8);
}

@immutable
final class ApplicationConfiguration {
  const ApplicationConfiguration({
    this.androidPackageName,
    this.iOSAppId,
    this.huaweiAppId,
    this.iosLaunchIntune = false,
  });
  final String? androidPackageName;
  final String? iOSAppId;
  final String? huaweiAppId;
  final bool iosLaunchIntune;
}
