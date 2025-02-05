// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bloc_clean_architecture/src/common/blocs/indicator/bloc/indicator_bloc.dart'
    as _i257;
import 'package:bloc_clean_architecture/src/common/cubits/version_control/cubit/version_control_cubit.dart'
    as _i720;
import 'package:bloc_clean_architecture/src/common/localization/bloc/localization_bloc.dart'
    as _i913;
import 'package:bloc_clean_architecture/src/common/network_manager/network_manager.dart'
    as _i890;
import 'package:bloc_clean_architecture/src/common/shared_preferences_manager/shared_prefences_manager.dart'
    as _i152;
import 'package:bloc_clean_architecture/src/common/sqflite_manager/sqflite_manager.dart'
    as _i308;
import 'package:bloc_clean_architecture/src/common/theme/bloc/theme_bloc.dart'
    as _i564;
import 'package:bloc_clean_architecture/src/data/data_source/local/auth_local_ds.dart'
    as _i413;
import 'package:bloc_clean_architecture/src/data/data_source/local/localization/localization_local_ds.dart'
    as _i807;
import 'package:bloc_clean_architecture/src/data/data_source/local/theme/theme_local_ds.dart'
    as _i91;
import 'package:bloc_clean_architecture/src/data/data_source/local/todo_local_ds.dart'
    as _i283;
import 'package:bloc_clean_architecture/src/data/data_source/local/user_local_ds.dart'
    as _i493;
import 'package:bloc_clean_architecture/src/data/data_source/remote/auth_remote_ds.dart'
    as _i321;
import 'package:bloc_clean_architecture/src/data/data_source/remote/localization/localization_remote_ds.dart'
    as _i230;
import 'package:bloc_clean_architecture/src/data/data_source/remote/user_remote_ds.dart'
    as _i706;
import 'package:bloc_clean_architecture/src/domain/app_version_state/app_version_state_repository.dart'
    as _i1006;
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart'
    as _i291;
import 'package:bloc_clean_architecture/src/domain/indicator/indicator_repository.dart'
    as _i752;
import 'package:bloc_clean_architecture/src/domain/localization/localization_repository.dart'
    as _i749;
import 'package:bloc_clean_architecture/src/domain/network_manager/network_manager_repository.dart'
    as _i978;
import 'package:bloc_clean_architecture/src/domain/service_unavailable/service_unavailable_repository.dart'
    as _i1040;
import 'package:bloc_clean_architecture/src/domain/splash/splash_repository.dart'
    as _i183;
import 'package:bloc_clean_architecture/src/domain/sqflite_manager/sqflite_manager_repository.dart'
    as _i316;
import 'package:bloc_clean_architecture/src/domain/theme/theme_repository.dart'
    as _i626;
import 'package:bloc_clean_architecture/src/domain/todo/todo_repository.dart'
    as _i356;
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart'
    as _i85;
import 'package:bloc_clean_architecture/src/presentation/add_cosmetic/bloc/add_cosmetic_bloc.dart'
    as _i965;
import 'package:bloc_clean_architecture/src/presentation/home/bloc/home_bloc.dart'
    as _i827;
import 'package:bloc_clean_architecture/src/presentation/login/bloc/login_bloc.dart'
    as _i456;
import 'package:bloc_clean_architecture/src/presentation/profile/bloc/profile_bloc.dart'
    as _i199;
import 'package:bloc_clean_architecture/src/presentation/service_unavailable/bloc/service_unavailable_bloc.dart'
    as _i86;
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart'
    as _i369;
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/network_manager/bloc/manager/network_manager_bloc.dart'
    as _i57;
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/sqflite_manager/bloc/manager/sqflite_manager_bloc.dart'
    as _i865;
import 'package:bloc_clean_architecture/src/presentation/sign_up/bloc/sign_up_bloc.dart'
    as _i378;
import 'package:bloc_clean_architecture/src/presentation/splash/bloc/splash_bloc.dart'
    as _i982;
import 'package:bloc_clean_architecture/src/presentation/todo/bloc/todo_bloc.dart'
    as _i982;
import 'package:bloc_clean_architecture/src/presentation/todo/cubit/counter_cubit.dart'
    as _i240;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i965.AddCosmeticBloc>(() => _i965.AddCosmeticBloc());
    gh.factory<_i982.SplashBloc>(() => _i982.SplashBloc());
    gh.factory<_i240.CounterCubit>(() => _i240.CounterCubit());
    gh.singleton<_i308.SqfliteManager>(() => _i308.SqfliteManager());
    gh.lazySingleton<_i890.NetworkManager>(() => _i890.NetworkManager());
    gh.lazySingleton<_i152.SharedPreferencesManager>(
        () => _i152.SharedPreferencesManager());
    gh.lazySingleton<_i321.AuthRemoteDS>(() => const _i321.AuthRemoteDS());
    gh.lazySingleton<_i230.LocalizationRemoteDS>(
        () => const _i230.LocalizationRemoteDS());
    gh.lazySingleton<_i706.UserRemoteDS>(() => const _i706.UserRemoteDS());
    gh.lazySingleton<_i1006.AppVersionStateRepository>(
        () => _i1006.AppVersionStateRepository());
    gh.lazySingleton<_i752.IndicatorRepository>(
        () => _i752.IndicatorRepository());
    gh.lazySingleton<_i978.NetworkManagerRepository>(
        () => _i978.NetworkManagerRepository());
    gh.lazySingleton<_i1040.ServiceUnavailableRepository>(
        () => _i1040.ServiceUnavailableRepository());
    gh.lazySingleton<_i183.SplashRepository>(() => _i183.SplashRepository());
    gh.lazySingleton<_i316.SqfliteManagerRepository>(
        () => _i316.SqfliteManagerRepository());
    gh.lazySingleton<_i57.NetworkManagerBloc>(
        () => _i57.NetworkManagerBloc(gh<_i978.NetworkManagerRepository>()));
    gh.factory<_i720.VersionControlCubit>(() =>
        _i720.VersionControlCubit(gh<_i1006.AppVersionStateRepository>()));
    gh.lazySingleton<_i413.AuthLocalDS>(
        () => _i413.AuthLocalDS(gh<_i152.SharedPreferencesManager>()));
    gh.lazySingleton<_i807.LocalizationLocalDS>(
        () => _i807.LocalizationLocalDS(gh<_i152.SharedPreferencesManager>()));
    gh.lazySingleton<_i91.ThemeLocalDS>(
        () => _i91.ThemeLocalDS(gh<_i152.SharedPreferencesManager>()));
    gh.lazySingleton<_i493.UserLocalDS>(
        () => _i493.UserLocalDS(gh<_i152.SharedPreferencesManager>()));
    gh.lazySingleton<_i865.SqfliteManagerBloc>(
        () => _i865.SqfliteManagerBloc(gh<_i316.SqfliteManagerRepository>()));
    gh.lazySingleton<_i85.UserRepository>(() => _i85.UserRepository(
          gh<_i706.UserRemoteDS>(),
          gh<_i493.UserLocalDS>(),
        ));
    gh.lazySingleton<_i749.LocalizationRepository>(
        () => _i749.LocalizationRepository(
              gh<_i807.LocalizationLocalDS>(),
              gh<_i230.LocalizationRemoteDS>(),
            ));
    gh.lazySingleton<_i283.TodoLocalDS>(
        () => _i283.TodoLocalDS(gh<_i308.SqfliteManager>()));
    gh.singleton<_i913.LocalizationBloc>(
        () => _i913.LocalizationBloc(gh<_i749.LocalizationRepository>()));
    gh.lazySingleton<_i257.IndicatorBloc>(
        () => _i257.IndicatorBloc(gh<_i752.IndicatorRepository>()));
    gh.lazySingleton<_i86.ServiceUnavailableBloc>(() =>
        _i86.ServiceUnavailableBloc(gh<_i1040.ServiceUnavailableRepository>()));
    gh.lazySingleton<_i291.AuthRepository>(() => _i291.AuthRepository(
          gh<_i321.AuthRemoteDS>(),
          gh<_i413.AuthLocalDS>(),
        ));
    gh.lazySingleton<_i369.AuthBloc>(
        () => _i369.AuthBloc(gh<_i291.AuthRepository>()));
    gh.lazySingleton<_i626.ThemeRepository>(
        () => _i626.ThemeRepository(gh<_i91.ThemeLocalDS>()));
    gh.lazySingleton<_i564.ThemeBloc>(
        () => _i564.ThemeBloc(gh<_i626.ThemeRepository>()));
    gh.factory<_i827.HomeBloc>(() => _i827.HomeBloc(
          gh<_i291.AuthRepository>(),
          gh<_i85.UserRepository>(),
        ));
    gh.factory<_i456.LoginBloc>(() => _i456.LoginBloc(
          gh<_i291.AuthRepository>(),
          gh<_i85.UserRepository>(),
        ));
    gh.factory<_i378.SignUpBloc>(() => _i378.SignUpBloc(
          gh<_i291.AuthRepository>(),
          gh<_i85.UserRepository>(),
        ));
    gh.lazySingleton<_i356.TodoRepository>(
        () => _i356.TodoRepository(gh<_i283.TodoLocalDS>()));
    gh.factory<_i199.ProfileBloc>(() => _i199.ProfileBloc(
          gh<_i291.AuthRepository>(),
          gh<_i85.UserRepository>(),
          gh<_i626.ThemeRepository>(),
          gh<_i749.LocalizationRepository>(),
        ));
    gh.factory<_i982.TodoBloc>(
        () => _i982.TodoBloc(gh<_i356.TodoRepository>()));
    return this;
  }
}
