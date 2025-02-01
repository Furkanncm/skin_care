import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:flutter_core/flutter_core.dart';

abstract class MyFunctions {
  static RoutePaths? convertFullPathToEnum(String? fullPath) {
    if (fullPath.isNull) return null;
    return RoutePaths.values.firstWhere((e) => e.asRoutePath.replaceAll('/', '') == fullPath!.split('/').last);
  }
}
