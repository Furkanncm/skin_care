import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_pref_keys.dart';
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/color_scheme/dto/color_scheme_dto.dart';
import 'package:injectable/injectable.dart';

abstract interface class IThemeLocalDS {
  Future<bool> setColorSchemes(List<MyColorSchemeDto> colorSchemeList);

  List<MyColorSchemeDto>? getColorSchemes();
}

@lazySingleton
class ThemeLocalDS implements IThemeLocalDS {
  const ThemeLocalDS(this._pref);
  final SharedPreferencesManager _pref;

  @override
  Future<bool> setColorSchemes(List<MyColorSchemeDto> colorSchemeList) => _pref.setObjectList(key: SharedPrefKeys.colorSchemeList, value: colorSchemeList);

  @override
  List<MyColorSchemeDto>? getColorSchemes() => _pref.getObjectList(key: SharedPrefKeys.colorSchemeList, model: const MyColorSchemeDto());
}
