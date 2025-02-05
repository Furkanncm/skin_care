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
      title: Column(
        children: [
          CoreText.headlineMedium(LocalizationKey.myProfile.value),
          verticalBox4,
          Divider(),
        ],
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
    return Stack(
      children: [
        Padding(
          padding: AppConstants.paddingConstants.pagePadding,
          child: Column(
            children: [
              Column(
                children: [
                  _UserInfoField(),
                  verticalBox20,
                  _ThemeChangeField(),
                ],
              ),
              Expanded(child: emptyBox),
            ],
          ),
        ),
        _LogOutButton(),
      ],
    );
  }
}

@immutable
final class _LogOutButton extends StatelessWidget {
  const _LogOutButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: CoreOutlinedButton.autoIndicator(
          child: Center(child: CoreText.bodyLarge(LocalizationKey.logout.value)),
          onPressed: () async {
            final isLogOut = await SCDialogs.showLogoutDialog(context: context);
            if (isLogOut ?? false) context.read<ProfileBloc>().add(ProfileLogOutEvent());
          },
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
    final bloc = context.watch<ProfileBloc>();
    final user = bloc.state.user;
    return Container(
      width: double.infinity,
      height: context.height * 0.15,
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: context.colorScheme.primary,
            child: CoreText.headlineMedium(
              (user?.name?.characters.first.toUpperCase() ?? '') + (user?.surName?.characters.first.toUpperCase() ?? ''),
              textColor: context.colorScheme.onPrimary,
            ),
          ),
          title: CoreText.titleLarge((user?.name ?? '') + ' ' + (user?.surName ?? '')),
          subtitle: CoreText.bodyMedium(user?.email ?? ''),
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
      height: context.height * 0.3,
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
