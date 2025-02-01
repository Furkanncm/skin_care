import 'package:bloc_clean_architecture/src/common/blocs/indicator/bloc/indicator_bloc.dart';
import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/cubits/version_control/cubit/version_control_cubit.dart';
import 'package:bloc_clean_architecture/src/common/localization/bloc/localization_bloc.dart';
import 'package:bloc_clean_architecture/src/common/theme/bloc/theme_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/service_unavailable/bloc/service_unavailable_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/network_manager/bloc/manager/network_manager_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/sqflite_manager/bloc/manager/sqflite_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
final class AppEntryMultiBlocProvider extends StatelessWidget {
  const AppEntryMultiBlocProvider({required this.builder, super.key});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<NetworkManagerBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<IndicatorBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SqfliteManagerBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<LocalizationBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ServiceUnavailableBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<VersionControlCubit>(),
          lazy: false,
        ),
      ],
      child: Builder(builder: builder),
    );
  }
}
