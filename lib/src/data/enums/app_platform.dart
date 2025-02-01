import 'dart:io';

import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

enum AppPlatform {
  @JsonValue(1)
  android(1),
  @JsonValue(2)
  ios(2),
  @JsonValue(3)
  huawei(3),
  ;

  const AppPlatform(this.value);

  final int value;

  static Future<AppPlatform> getAppPlatform() async {
    if (Platform.isIOS) return AppPlatform.ios;
    if (await DeviceType.isHuawei()) return AppPlatform.huawei;
    return AppPlatform.android;
  }
}
