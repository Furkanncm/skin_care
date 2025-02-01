import 'dart:async';

import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/cubits/version_control/cubit/version_control_cubit.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/theme/bloc/theme_bloc.dart';
import 'package:bloc_clean_architecture/src/data/model/color_scheme/dto/color_scheme_dto.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:bloc_clean_architecture/src/presentation/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizationKey.settings.tr(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<SettingsBloc>()..add(const SettingsInitializedEvent()),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state.status == SettingsStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SingleChildScrollView(
                child: Column(
                  children: [
                    _ThemeList(),
                    verticalBox32,
                    _CultureList(),
                    verticalBox12,
                    _CurrentVersionInfo(),
                    verticalBox12,
                    _UpdateAvailableInfo(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

@immutable
final class _ThemeList extends StatelessWidget {
  const _ThemeList();

  @override
  Widget build(BuildContext context) {
    final colorSchemes = context.watch<SettingsBloc>().state.colorSchemes;
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final colorScheme = colorSchemes[index];
          return _ThemeOptionListTile(colorScheme: colorScheme);
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: colorSchemes.length,
      ),
    );
  }
}

@immutable
final class _ThemeOptionListTile extends StatelessWidget {
  const _ThemeOptionListTile({
    required this.colorScheme,
  });

  final MyColorSchemeDto colorScheme;

  @override
  Widget build(BuildContext context) {
    final currentColorScheme = context.watch<ThemeBloc>().state.colorScheme;

    return ListTile(
      enabled: currentColorScheme != colorScheme,
      leading: colorScheme.brightness == Brightness.dark
          ? const Icon(
              Icons.dark_mode,
            )
          : const Icon(
              Icons.light_mode_outlined,
            ),
      title: Text(colorScheme.brightness == Brightness.dark ? LocalizationKey.dark.tr(context) : LocalizationKey.light.tr(context)),
      trailing: currentColorScheme == colorScheme ? const Icon(Icons.check_circle_outline) : null,
      onTap: () => context.read<ThemeBloc>().add(ThemeChangedEvent(colorScheme: colorScheme)),
    );
  }
}

@immutable
final class _CultureList extends StatelessWidget {
  const _CultureList();

  @override
  Widget build(BuildContext context) {
    final cultures = context.watch<SettingsBloc>().state.cultures;
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return _CultureListTile(culture: cultures![index]);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: cultures?.length ?? 0,
      ),
    );
  }
}

@immutable
final class _CultureListTile extends StatelessWidget {
  const _CultureListTile({required this.culture});

  final Culture culture;

  @override
  Widget build(BuildContext context) {
    final isSelectedCulture = context.watch<SettingsBloc>().state.selectedCulture == culture;
    return ListTile(
      leading: isSelectedCulture ? const Icon(Icons.check) : null,
      title: Text(culture.description ?? ''),
      enabled: !isSelectedCulture,
      onTap: () {
        context.read<SettingsBloc>().add(LanguageChangedEvent(culture: culture));
      },
    );
  }
}

@immutable
final class _CurrentVersionInfo extends StatefulWidget {
  const _CurrentVersionInfo();

  @override
  State<_CurrentVersionInfo> createState() => _CurrentVersionInfoState();
}

class _CurrentVersionInfoState extends State<_CurrentVersionInfo> {
  String? version;
  String? buildNumber;

  @override
  void initState() {
    CorePackageInfo.instance.version.then(
      (value) => scheduleMicrotask(
        () => setState(() => version = value),
      ),
    );
    CorePackageInfo.instance.buildNumber.then(
      (value) => scheduleMicrotask(
        () => setState(() => buildNumber = value),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CoreText.bodyMedium(
        '$version ($buildNumber)',
        textAlign: TextAlign.center,
      ),
    );
  }
}

@immutable
final class _UpdateAvailableInfo extends StatelessWidget {
  const _UpdateAvailableInfo();

  @override
  Widget build(BuildContext context) {
    final versionControlCubitState = context.read<VersionControlCubit>().state;

    if (versionControlCubitState is VersionControlOptionalUpdateAvailable) {
      return Column(
        children: [
          const Divider(
            indent: 16,
            endIndent: 16,
          ),
          CoreText.bodyMedium(
            '${LocalizationKey.newVersionAvailable.tr(context)} ${versionControlCubitState.version}',
            textAlign: TextAlign.center,
          ),
          verticalBox4,
          OutlinedButton(
            style: OutlinedButton.styleFrom(),
            child: CoreText.labelMedium(
              LocalizationKey.update.tr(context),
              fontWeight: FontWeight.bold,
            ),
            onPressed: () async {
              final configuration = AppConstants.configuration.applicationConfiguration;
              await Core.updateApp(
                androidPackageName: configuration.androidPackageName,
                iosLaunchIntune: configuration.iosLaunchIntune,
              );
            },
          ),
        ],
      );
    }

    return emptyBox;
  }
}
