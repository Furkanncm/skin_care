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
        body: _Body(),
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: AppConstants.paddingConstants.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            verticalBox64 + verticalBox64 + verticalBox64,
            CoreText.headlineMedium(LocalizationKey.welcome.value, fontWeight: FontWeight.bold, textColor: context.colorScheme.primary),
            verticalBox8,
            CoreText.bodyLarge(LocalizationKey.firstLogin.value, textColor: context.colorScheme.onSurface.withOpacity(0.4)),
            verticalBox64 + verticalBox64,
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
            verticalBox16,
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(onTap: () {}, child: CoreText.bodyMedium(LocalizationKey.forgotPassword.value, textColor: context.colorScheme.primary)),
            ),
            verticalBox32,
            _LoginButton(),
            verticalBox16,
            _NoAccountField()
          ],
        ),
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
        prefixIcon: Icon(Icons.email_outlined),
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
      prefixIcon: Icon(Icons.lock_outline_rounded),
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
    return CoreOutlinedButton.autoIndicator(
      child: Center(child: CoreText.bodyLarge(LocalizationKey.login.tr(context))),
      onPressed: () => bloc.add(LoginButtonPressedEvent()),
    );
  }
}

@immutable
final class _NoAccountField extends StatelessWidget {
  const _NoAccountField();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CoreText.bodyMedium(LocalizationKey.noAccount.value, textColor: context.colorScheme.onSurface.withOpacity(0.4)),
        horizontalBox4,
        GestureDetector(onTap: () => router.pushReplacementNamed(RoutePaths.signUp.name), child: CoreText.bodyMedium(LocalizationKey.signUp.value, textColor: context.colorScheme.primary)),
      ],
    );
  }
}
