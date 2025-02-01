import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/routing/router.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/domain/splash/splash_repository.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/splash/retriables/color_scheme_retriable.dart';
import 'package:bloc_clean_architecture/src/presentation/splash/retriables/localization_retriable.dart';
import 'package:bloc_clean_architecture/src/presentation/splash/retriables/version_control_retriable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInitializedEvent>(_initialize);
  }

  final _splashRepository = getIt<SplashRepository>();
  final _userRepository = getIt<UserRepository>();
  final _authRepository = getIt<AuthRepository>();

  // Retriables
  final _versionControlRetriable = VersionControlRetriable();
  final _localizationRetriable = LocalizationRetriable();
  final _colorSchemeRetriable = ColorSchemeRetriable();

  Future<void> _initialize(SplashInitializedEvent event, Emitter<SplashState> emit) async {
    emit(SplashInitial());
    await Future<void>.delayed(const Duration(milliseconds: 300));

    try {
      // Versiyon kontrol edilir.
      await _checkForUpdate();

      // SharedPrefences ve Sqflite veritabanı başlatılır.
      await _initializeLocalStorages();

      // Lokal dil dosyaları yüklenir.
      await _getLocalizations();

      // Tema renkleri yüklenir.
      await _initializeColorSchemes();

      // Auth state başlatılır.
      _initializeAuthState();
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }

  /// Güncel versiyon bilgilerini almak için Retriable yardımıyla servise istek atılıyor.
  /// Eğer yeni bir versiyon varsa ve zorunlu güncelleme varsa dialog gösterilip güncelleme yapılmaya çalışılıyor.
  /// Güncelleme varsa ve zorunlu güncelleme değilse ayarlar ekranında güncelleme tasarımı gösteriliyor.
  Future<void> _checkForUpdate() async {
    final response = await _versionControlRetriable.execute();
    final forceUpdate = response.data?.forceUpdate ?? false;
    if (forceUpdate) await popupManager.showUpdateAvailableDialog(isForceUpdate: forceUpdate);
  }

  /// Shared Preferences ve SqLite lokal veritabanı ayağa kaldırılıyor.
  Future<void> _initializeLocalStorages() {
    return _splashRepository.initializeLocalStorages();
  }

  /// Dil bilgileri Retriable yardımıyla servisten alınıyor.
  Future<void> _getLocalizations() {
    return _localizationRetriable.execute();
  }

  /// Tema bilgileri alınıyor. İsteğe bağlı olarak Retriable yardımıyla servisten de alınabilir.
  Future<bool> _initializeColorSchemes() {
    return _colorSchemeRetriable.execute();
  }

  /// Lokalden User ve UserCredentials bilgileri alınıyor. Eğer bu bilgiler null değilse kullanıcı oturum açmış durumdadır. AuthRepository yardımıyla AuthBloc'a bilgiler setleniyor.
  void _initializeAuthState() {
    final user = _userRepository.getLocalUser();
    final userCredentials = _authRepository.getUserCredentials();

    if (user.isNotNull && userCredentials.isNotNull) {
      _authRepository.changeAuthState(
        authState: AuthState.authenticated(
          user: user,
          userCredentials: userCredentials,
        ),
      );
    } else {
      _authRepository.changeAuthState(
        authState: const AuthState.unAuthenticated(),
      );
    }
  }
}
