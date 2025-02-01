import 'package:bloc_clean_architecture/src/common/localization/bloc/localization_bloc.dart';
import 'package:bloc_clean_architecture/src/common/routing/router.dart';
import 'package:bloc_clean_architecture/src/common/theme/bloc/theme_bloc.dart';
import 'package:bloc_clean_architecture/src/common/theme/sl_color_scheme_extension.dart';
import 'package:bloc_clean_architecture/src/common/widgets/app_entry_multi_bloc_listener/app_entry_multi_bloc_listener.dart';
import 'package:bloc_clean_architecture/src/common/widgets/app_entry_multi_bloc_provider/app_entry_multi_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BlocApp extends StatelessWidget {
  const BlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEntryMultiBlocProvider(
      builder: (context) {
        return MaterialApp.router(
          routerConfig: router,
          theme: context.watch<ThemeBloc>().state.colorScheme?.theme,
          supportedLocales: supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return AppEntryMultiBlocListener(
              builder: (context) => CoreBuilder(child: child),
            );
          },
          locale: context.watch<LocalizationBloc>().state.culture?.locale,
        );
      },
    );
  }
}
