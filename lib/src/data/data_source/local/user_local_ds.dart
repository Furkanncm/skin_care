import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_pref_keys.dart';
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:injectable/injectable.dart';

abstract interface class IUserLocalDS {
  Future<bool> setUser({required MyUser user});
  MyUser? getUser();
  Future<bool> deleteUser();
}

@lazySingleton
final class UserLocalDS implements IUserLocalDS {
  UserLocalDS(this._pref);
  final SharedPreferencesManager _pref;

  @override
  Future<bool> setUser({required MyUser user}) => _pref.setObject(key: SharedPrefKeys.user, value: user);

  @override
  MyUser? getUser() => _pref.getObject<MyUser>(key: SharedPrefKeys.user, model: MyUser());

  @override
  Future<bool> deleteUser() => _pref.remove(key: SharedPrefKeys.user);
}
