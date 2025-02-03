import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../common/routing/router.dart';

@immutable
final class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignUpBloc>(),
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
      title: CoreText.headlineMedium(LocalizationKey.signUp.tr(context)),
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
    final bloc = context.read<SignUpBloc>();
    return Padding(
      padding: AppConstants.paddingConstants.pagePadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: bloc.formKey,
              child: Column(
                children: [
                  _NameField(),
                  verticalBox16,
                  _SurnameField(),
                  verticalBox16,
                  _EmailField(),
                  verticalBox16,
                  _PasswordField(),
                  verticalBox16,
                  _PasswordAgainField(),
                ],
              ),
            ),
            verticalBox12,
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(onTap: () => router.goNamed(RoutePaths.login.name), child: CoreText.bodyMedium(LocalizationKey.alreadyHaveAccount.value)),
            ),
            verticalBox16,
            _SignUpButton()
          ],
        ),
      ),
    );
  }
}

@immutable
final class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return TextFormField(
      controller: bloc.nameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: LocalizationKey.name.value,
        border: OutlineInputBorder(),
      ),
      validator: (value) => value?.isNotNullAndNotEmpty ?? false ? null : LocalizationKey.fieldRequired.value,
    );
  }
}

@immutable
final class _SurnameField extends StatelessWidget {
  const _SurnameField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return TextFormField(
      controller: bloc.surnameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: LocalizationKey.surname.value,
        border: OutlineInputBorder(),
      ),
      validator: (value) => value?.isNotNullAndNotEmpty ?? false ? null : LocalizationKey.fieldRequired.value,
    );
  }
}

@immutable
final class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
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
    final bloc = context.read<SignUpBloc>();
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
final class _PasswordAgainField extends StatelessWidget {
  const _PasswordAgainField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return CorePasswordTextField(
      controller: bloc.passwordAgainController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      labelText: LocalizationKey.passwordAgain.value,
      validator: (value) {
        if (value == null) return null;
        if (value != bloc.passwordController.text) {
          return LocalizationKey.passwordsDoNotMatch.value;
        }
        return null;
      },
    );
  }
}

@immutable
final class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width / 2,
      child: CoreOutlinedButton.autoIndicator(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoreText.bodyLarge(LocalizationKey.signUp.tr(context)),
            horizontalBox20,
            Icon(Icons.login_outlined),
          ],
        ),
        onPressed: () => context.read<SignUpBloc>().add(SignUpButtonPressedEvent()),
      ),
    );
  }
}
