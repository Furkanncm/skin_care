import 'dart:io';

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
import 'enum/profil_info_enum.dart';

@immutable
final class ProfileView extends StatefulWidget {
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
      backgroundColor: context.colorScheme.primary,
      centerTitle: true,
      title: CoreText.headlineSmall(LocalizationKey.myProfile.tr(context), textColor: context.colorScheme.onPrimary),
      actions: [
        IconButton(
          icon: Icon(Icons.logout_outlined, color: context.colorScheme.surface, size: 30),
          onPressed: () async {
            final isLogOut = await SCDialogs.showLogoutDialog(context: context);
            if (isLogOut ?? false) context.read<ProfileBloc>().add(ProfileLogOutEvent());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ProfileBloc>();
    final user = bloc.state.user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _UserInfoField(),
        verticalBox12,
        _ThemeChangeField(),
        Padding(
          padding: AppConstants.paddingConstants.pageLowPadding,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ProfilInfoEnum.values.toList().map((e) {
                return ListTile(
                  title: CoreText.bodyLarge(e.name.characters.first.toUpperCase() + e.name.substring(1)),
                  trailing: CoreText.bodyMedium(e.value(user)),
                );
              }).toList()),
        ),
      ],
    );
  }
}

@immutable
final class _UserInfoField extends StatelessWidget {
  const _UserInfoField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ProfileBloc>();
    final user = bloc.state.user;
    return Container(
      height: context.height * 0.2,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Padding(
        padding: AppConstants.paddingConstants.pagePadding,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 115,
                  height: 115,
                  child: Stack(
                    children: [
                      ClipOval(
                        child: Container(
                          padding: EdgeInsets.zero,
                          width: 100,
                          height: 100,
                          color: context.colorScheme.surface,
                          child: Image.file(
                            File(user?.imagePath ?? ''),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Center(
                              child: CoreText.displayMedium(user?.name?.characters.first.toUpperCase() ?? ''),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorScheme.surface,
                          ),
                          child: CoreIconButton(
                            icon: Icon(Icons.camera_alt_outlined),
                            onPressed: () => context.read<ProfileBloc>().add(ProfileChangePhotoEvent()),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                horizontalBox20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CoreText.headlineSmall(
                      (user?.name ?? '').characters.first.toUpperCase() + (user?.name ?? '').substring(1) + ' ' + (user?.surName ?? '').characters.first.toUpperCase() + (user?.surName ?? '').substring(1),
                      textColor: context.colorScheme.onPrimary,
                    ),
                    CoreText.titleSmall(user?.email ?? '', textColor: context.colorScheme.onPrimary),
                  ],
                ),
              ],
            ),
          ],
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
    return Padding(
      padding: AppConstants.paddingConstants.pageLowPadding,
      child: SizedBox(
        height: context.height * 0.15,
        child: ListView.separated(
          itemBuilder: (context, index) {
            final colorScheme = context.watch<ProfileBloc>().state.colorSchemes[index];
            return _ThemeOptionListTile(colorScheme: colorScheme);
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: context.watch<ProfileBloc>().state.colorSchemes.length,
        ),
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
