import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/presentation/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../common/routing/router.dart';

@immutable
final class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: const Scaffold(
        appBar: _AppBar(),
        body: _Body(),
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
      centerTitle: true,
      title: CoreText.headlineMedium(LocalizationKey.login.tr(context)),
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
    final bloc = context.read<LoginBloc>();
    return Padding(
      padding: AppConstants.paddingConstants.pagePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: bloc.formKey,
            child: Column(
              children: [
                _EmailField(),
                verticalBox16,
                _PasswordField(),
              ],
            ),
          ),
          verticalBox12,
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(onTap: () => router.goNamed(RoutePaths.signUp.name), child: CoreText.bodyMedium(LocalizationKey.createAccount.value)),
          ),
          verticalBox12,
          _LoginButton()
        ],
      ),
    );
  }
}

@immutable
final class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return TextFormField(
      controller: bloc.emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: LocalizationKey.email.value,
        border: OutlineInputBorder(),
      ),
      validator: (value) => value?.isEmail ?? false ? null : LocalizationKey.inValidEmail.value,
    );
  }
}

@immutable
final class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return CorePasswordTextField(
      controller: bloc.passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      labelText: LocalizationKey.password.value,
      validator: (value) {
        if (value == null) return null;
        if (value.isEmpty) {
          return LocalizationKey.cantEmptyPassword.value;
        } else if (value.length < 6) {
          return LocalizationKey.password6char.value;
        } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
          return LocalizationKey.passwordbigChar.value;
        } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
          return LocalizationKey.password1number.value;
        }
        return null;
      },
    );
  }
}

@immutable
final class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return SizedBox(
      width: context.width / 2,
      child: CoreOutlinedButton.autoIndicator(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoreText.bodyLarge(LocalizationKey.login.tr(context)),
            horizontalBox20,
            Icon(Icons.login_outlined),
          ],
        ),
        onPressed: () => bloc.add(LoginButtonPressedEvent()),
      ),
    );
  }
}
