import 'package:bloc_clean_architecture/src/common/constants/env.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class SharedPreferencesManager extends CoreSharedPreferencesManager {
  SharedPreferencesManager() : super(encryptionKey: Env.encryptionKey, encryptionIv: Env.encryptionIv);
}
