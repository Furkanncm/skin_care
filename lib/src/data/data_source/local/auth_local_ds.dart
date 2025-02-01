import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_pref_keys.dart';
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user_credentials/my_user_credentials.dart';
import 'package:injectable/injectable.dart';

abstract interface class IAuthLocalDS {
  Future<bool> deleteUserCredentials();
  Future<bool> setUserCredentials({required MyUserCredentials myUserCredentials});
  MyUserCredentials? getUserCredentials();
}

@lazySingleton
final class AuthLocalDS implements IAuthLocalDS {
  AuthLocalDS(this._pref);

  final SharedPreferencesManager _pref;

  @override
  Future<bool> deleteUserCredentials() => _pref.remove(key: SharedPrefKeys.userCredentials);

  @override
  Future<bool> setUserCredentials({required MyUserCredentials myUserCredentials}) => _pref.setObject<MyUserCredentials>(key: SharedPrefKeys.userCredentials, value: myUserCredentials);

  @override
  MyUserCredentials? getUserCredentials() => _pref.getObject<MyUserCredentials>(
        key: SharedPrefKeys.userCredentials,
        model: const MyUserCredentials(),
      );
}
