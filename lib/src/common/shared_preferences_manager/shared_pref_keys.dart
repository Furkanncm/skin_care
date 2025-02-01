import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user_credentials/my_user_credentials.dart';
import 'package:flutter_core/flutter_core.dart';

enum SharedPrefKeys implements BaseSharedPrefKeys {
  /// This is [List<SLColorScheme>] Object
  colorSchemeList(),

  /// This is [String] Object
  username(),

  /// This is [String] Object
  token(),

  /// This is [MyUserCredentials] Object and it is encrypted
  userCredentials(encrypt: true),

  /// This is [MyUser] Object and it is encrypted
  user(encrypt: true),

  /// This is [Culture] Object and it is encrypted
  locale(encrypt: true),

  culture(),
  ;

  const SharedPrefKeys({this.encrypt = false});

  @override
  final bool encrypt;

  @override
  String get keyName => name;
}
