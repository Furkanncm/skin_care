import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_pref_keys.dart';
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:injectable/injectable.dart';

abstract interface class ILocalizationLocalDS {
  Culture? getCulture();
  Future<bool> saveCulture(Culture culture);
}

@lazySingleton
class LocalizationLocalDS implements ILocalizationLocalDS {
  const LocalizationLocalDS(this._pref);
  final SharedPreferencesManager _pref;

  @override
  Culture? getCulture() => _pref.getObject(key: SharedPrefKeys.culture, model: const Culture());

  @override
  Future<bool> saveCulture(Culture culture) => _pref.setObject(key: SharedPrefKeys.culture, value: culture);
}
