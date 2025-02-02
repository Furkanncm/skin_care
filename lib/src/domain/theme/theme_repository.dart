import 'dart:async';
import 'dart:io';

import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/common/theme/sl_color_scheme_default.dart';
import 'package:bloc_clean_architecture/src/data/data_source/local/theme/theme_local_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/color_scheme/dto/color_scheme_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

mixin IThemeRepository {
  List<MyColorSchemeDto> getColorSchemesFromLocal();

  Future<List<MyColorSchemeDto>> getColorSchemes();
}

@lazySingleton
final class ThemeRepository implements IThemeRepository {
  ThemeRepository(this._themeLocalDS);

  final ThemeLocalDS _themeLocalDS;

  final StreamController<List<MyColorSchemeDto>> _controller = StreamController<List<MyColorSchemeDto>>();

  Stream<List<MyColorSchemeDto>> get status async* {
    yield* _controller.stream;
  }

  @override
  List<MyColorSchemeDto> getColorSchemesFromLocal() => _themeLocalDS.getColorSchemes() ?? SCColorSchemeDefault.themes;

  @override
  Future<List<MyColorSchemeDto>> getColorSchemes() async {
    final response = await _getColorSchemesFromRemote();
    if (response.data != null) await _setColorSchemesToLocal(response.data!);
    final colorSchemeList = response.data ?? getColorSchemesFromLocal();
    _controller.add(colorSchemeList);
    return colorSchemeList;
  }

  Future<BaseResponse<List<MyColorSchemeDto>>> _getColorSchemesFromRemote() async {
    const response = BaseResponse<List<MyColorSchemeDto>>(error: SocketException('No internet connection'));

    if (response.data == null) return BaseResponse(error: Exception('No data'));
    if (response.data!.length != 2) return BaseResponse(error: Exception('Data is not valid'));
    if (!response.data!.any((element) => element.brightness == Brightness.dark)) return BaseResponse(error: Exception('Data is not valid'));
    if (!response.data!.any((element) => element.brightness == Brightness.light)) return BaseResponse(error: Exception('Data is not valid'));
    return response;
  }

  Future<bool> _setColorSchemesToLocal(List<MyColorSchemeDto> colorSchemeList) => _themeLocalDS.setColorSchemes(colorSchemeList);
}
