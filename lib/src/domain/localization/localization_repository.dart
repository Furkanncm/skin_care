import 'dart:async';

import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/data/data_source/local/localization/localization_local_ds.dart';
import 'package:bloc_clean_architecture/src/data/data_source/remote/localization/localization_remote_ds.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:injectable/injectable.dart';

abstract interface class ILocalizationRepository {
  Future<BaseResponse<List<Culture>>> getCultures();

  Future<bool> changeCulture(Culture culture);

  Culture? getSelectedCulture();
}

@lazySingleton
final class LocalizationRepository implements ILocalizationRepository {
  LocalizationRepository(
    this._localizationLocalDS,
    this._localizationRemoteDS,
  );

  final LocalizationLocalDS _localizationLocalDS;
  final LocalizationRemoteDS _localizationRemoteDS;

  final _controller = StreamController<Culture>.broadcast();

  Stream<Culture> get status async* {
    yield* _controller.stream;
  }

  @override
  Future<BaseResponse<List<Culture>>> getCultures() => _localizationRemoteDS.getCultures();

  @override
  Culture? getSelectedCulture() => _localizationLocalDS.getCulture();

  @override
  Future<bool> changeCulture(Culture culture) async {
    final result = await _localizationLocalDS.saveCulture(culture);
    if (result) _controller.add(culture);
    return result;
  }

  void dispose() {
    _controller.close();
  }
}
