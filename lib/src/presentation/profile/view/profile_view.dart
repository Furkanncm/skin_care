import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/presentation/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../common/dialogs/sc_dialogs.dart';
import '../../../common/localization/localization_key.dart';
import '../../../common/theme/bloc/theme_bloc.dart';
import '../../../common/widgets/adaptive_indicator/adaptive_indicator.dart';
import '../../../data/model/color_scheme/dto/color_scheme_dto.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(ProfileEventInitialize()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) AdaptiveIndicator();
          return Scaffold(
            appBar: _AppBar(),
            body: _Body(),
          );
        },
      ),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: AppConstants.paddingConstants.horizontalPadding,
        child: CoreText.headlineMedium(
          LocalizationKey.settings.value,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppConstants.paddingConstants.pagePadding,
        child: Column(
          children: [
            Divider(),
            verticalBox16,
            _UserInfoField(),
            verticalBox20,
            _ThemeChangeField(),
            verticalBox64 + verticalBox64 + verticalBox64,
            CoreOutlinedButton.autoIndicator(
                child: Center(child: CoreText.bodyLarge(LocalizationKey.logout.value)),
                onPressed: () async {
                  final isLogOut = await SCDialogs.showLogoutDialog(context: context);
                  if (isLogOut ?? false) context.read<ProfileBloc>().add(ProfileLogOutEvent());
                }),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _UserInfoField extends StatelessWidget {
  const _UserInfoField();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.height * 0.15,
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: AppConstants.paddingConstants.pagePadding,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: context.colorScheme.primary,
            child: CoreText.headlineMedium(
              LocalizationKey.name.value[0],
              textColor: context.colorScheme.onPrimary,
            ),
          ),
          title: CoreText.titleLarge("Betül Anaçoğlu"),
          subtitle: CoreText.bodyMedium(
            LocalizationKey.email.value,
          ),
        ),
      ),
    );
  }
}

@immutable
final class _ThemeChangeField extends StatelessWidget {
  const _ThemeChangeField();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final colorScheme = context.watch<ProfileBloc>().state.colorSchemes[index];
          return _ThemeOptionListTile(colorScheme: colorScheme);
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: context.watch<ProfileBloc>().state.colorSchemes.length,
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
      title: CoreText.bodyLarge(colorScheme.brightness == Brightness.dark ? LocalizationKey.dark.tr(context) : LocalizationKey.light.tr(context)),
      trailing: currentColorScheme == colorScheme ? const Icon(Icons.check_circle_outline) : null,
      onTap: () => context.read<ThemeBloc>().add(ThemeChangedEvent(colorScheme: colorScheme)),
    );
  }
}
