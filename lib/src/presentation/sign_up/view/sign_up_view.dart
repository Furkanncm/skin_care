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
    final bloc = context.read<SignUpBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: AppConstants.paddingConstants.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            verticalBox64 + verticalBox32,
            CoreText.headlineMedium(LocalizationKey.signUp.value, fontWeight: FontWeight.bold, textColor: context.colorScheme.primary),
            verticalBox8,
            CoreText.bodyLarge(LocalizationKey.slogan.value, textColor: context.colorScheme.onSurface.withOpacity(0.4)),
            verticalBox64,
            Form(
              key: bloc.formKey,
              child: Column(
                children: [
                  _NameAndSurnameField(),
                  verticalBox16,
                  _EmailField(),
                  verticalBox16,
                  _PasswordField(),
                  verticalBox16,
                  _PasswordAgainField(),
                ],
              ),
            ),
            verticalBox48,
            _SignUpButton(),
            verticalBox16,
            _HaveAccountField()
          ],
        ),
      ),
    );
  }
}

@immutable
final class _NameAndSurnameField extends StatelessWidget {
  const _NameAndSurnameField();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _NameField(),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: _SurnameField(),
        )),
      ],
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
        prefixIcon: Icon(Icons.person_2_outlined),
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
        prefixIcon: Icon(Icons.person_2_outlined),
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
    final bloc = context.read<SignUpBloc>();
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
final class _PasswordAgainField extends StatelessWidget {
  const _PasswordAgainField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return CorePasswordTextField(
      prefixIcon: Icon(Icons.lock_outline_rounded),
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
    return CoreOutlinedButton.autoIndicator(
      child: Center(child: CoreText.bodyLarge(LocalizationKey.signUp.tr(context))),
      onPressed: () => context.read<SignUpBloc>().add(SignUpButtonPressedEvent()),
    );
  }
}

@immutable
final class _HaveAccountField extends StatelessWidget {
  const _HaveAccountField();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CoreText.bodyMedium(LocalizationKey.alreadyHaveAccount.value, textColor: context.colorScheme.onSurface.withOpacity(0.4)),
        horizontalBox4,
        GestureDetector(onTap: () => router.pushReplacementNamed(RoutePaths.login.name), child: CoreText.bodyMedium(LocalizationKey.login.value, textColor: context.colorScheme.primary)),
      ],
    );
  }
}
