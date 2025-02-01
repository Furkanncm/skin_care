import 'dart:async';

import 'package:bloc_clean_architecture/src/common/app_entry/app_entry.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/observers/bloc_observer.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runZonedGuarded(
    () async {
      try {
        configureDependencies();
        WidgetsFlutterBinding.ensureInitialized();
        if (!kIsWeb) {
          final appDocDir = await getApplicationDocumentsDirectory();
          final storage = await HydratedStorage.build(
            storageDirectory: HydratedStorageDirectory(appDocDir.path),
          );
          HydratedBloc.storage = storage;
        }

        Bloc.observer = OHBlocObserver();
        await Future.wait([
          Core.initialize(),
          // _initializeFirebase(),
        ]);

        /// **runApp çağrısını burada yap!**
        runApp(const BlocApp());
      } catch (error, stack) {
        if (kReleaseMode) {
          // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        }
      }
    },
    (error, stack) {
      if (kReleaseMode) {
        //  FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
    },
  );
}

// Future<void> _initializeFirebase() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   /// [instance] getter Firebase Analytics objesini oluşturur.
//   FirebaseAnalytics.instance;
// }