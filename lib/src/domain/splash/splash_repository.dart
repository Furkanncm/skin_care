import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart';
import 'package:bloc_clean_architecture/src/common/sqflite_manager/sqflite_manager.dart';
import 'package:injectable/injectable.dart';

mixin ISplashRepository {
  Future<void> initializeLocalStorages();
}

@lazySingleton
class SplashRepository with ISplashRepository {
  @override
  Future<void> initializeLocalStorages() {
    return Future.wait(
      [
        getIt<SqfliteManager>().openDB(),
        getIt<SharedPreferencesManager>().initialize(),
      ],
      eagerError: true,
    );
  }
}
