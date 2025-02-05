import 'package:bloc_clean_architecture/src/common/blocs/indicator/bloc/indicator_bloc.dart';
import 'package:bloc_clean_architecture/src/common/dialogs/sc_dialogs.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/message.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/routing/router.dart';
import 'package:bloc_clean_architecture/src/common/toasts/my_toasts.dart';
import 'package:bloc_clean_architecture/src/presentation/service_unavailable/bloc/service_unavailable_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/network_manager/bloc/manager/network_manager_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/sqflite_manager/bloc/manager/sqflite_manager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

@immutable
final class AppEntryMultiBlocListener extends StatelessWidget {
  const AppEntryMultiBlocListener({required this.builder, super.key});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _networkManagerBlocListener(),
        _sqfliteManagerBlocListener(),
        _indicatorBlocListener(),
        _authBlocListener(),
        _serviceUnavailableBlocListener(),
      ],
      child: Builder(builder: builder),
    );
  }

  BlocListener<NetworkManagerBloc, NetworkManagerState> _networkManagerBlocListener() {
    return BlocListener<NetworkManagerBloc, NetworkManagerState>(
      listener: (context, state) {
        if (rootNavigatorKey.currentContext == null) return;
        if (state.baseResponse == null) return;
        if (state.baseResponse?.statusCode == 503) return; // ServiceUnavailableBloc will handle this
        final baseResponse = state.baseResponse!;

        if (state is NetworkManagerSuccess && (baseResponse.messages.isNotNullAndNotEmpty)) {
          final messageType = baseResponse.messages!.first.type;
          switch (messageType) {
            case MessageType.success:
              SCToasts.showSuccessToast(
                message: baseResponse.messages!.map((message) => message.content).join('\n'),
              );

            case MessageType.info:
              SCToasts.showInfoToast(
                message: baseResponse.messages!.map((message) => message.content).join('\n'),
              );

            case MessageType.warning:
              SCToasts.showWarningToast(
                message: baseResponse.messages!.map((message) => message.content).join('\n'),
              );

            case MessageType.error:
              /* MyToasts.showErrorToast(
                message: baseResponse.messages!.map((message) => message.content).join('\n'),
              ); */
              SCDialogs.showErrorMessageDialog(
                message: baseResponse.messages!.map((message) => message.content).join('\n'),
                context: context,
              );
            case null:
              overlayManager.showToast(
                message: baseResponse.messages!.map((message) => message.content).join('\n'),
                messageMaxLines: 20,
              );
          }
        } else if (state is NetworkManagerError) {
          /* MyToasts.showErrorToast(
            message: baseResponse.messages.isNotNull ? baseResponse.messages!.map((message) => message.content).join('\n') : baseResponse.error?.toString() ?? LocalizationKey.unknownErrorOccured.tr(context),
          ); */
          SCDialogs.showErrorMessageDialog(
            message: baseResponse.messages.isNotNull ? baseResponse.messages!.map((message) => message.content).join('\n') : baseResponse.error?.toString() ?? LocalizationKey.unknownErrorOccured.tr(context),
            context: context,
          );
        }
      },
    );
  }

  BlocListener<SqfliteManagerBloc, SqfliteManagerState> _sqfliteManagerBlocListener() {
    return BlocListener<SqfliteManagerBloc, SqfliteManagerState>(
      listener: (context, state) {
        if (rootNavigatorKey.currentContext == null) return;
        if (state.baseResult == null) return;
        final baseResult = state.baseResult;

        if (state is SqfliteManagerSuccess) {
          SCToasts.showSuccessToast(
            message: LocalizationKey.operationSuccessful.tr(context),
          );
        } else if (state is SqfliteManagerError) {
          SCToasts.showErrorToast(
            message: baseResult?.error?.toString() ?? LocalizationKey.unknownErrorOccured.tr(context),
          );
        }
      },
    );
  }

  BlocListener<IndicatorBloc, IndicatorState> _indicatorBlocListener() {
    return BlocListener<IndicatorBloc, IndicatorState>(
      listener: (context, state) {
        if (state is IndicatorShow) {
          popupManager.showLoader(context: context, id: state.indicatorKey);
        } else if (state is IndicatorHide) {
          popupManager.hidePopup<void>(id: state.indicatorKey);
        }
      },
    );
  }

  BlocListener<AuthBloc, AuthState> _authBlocListener() {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthenticationStatus.unAuthenticated) {
          router.refresh();
        } else if (state.status == AuthenticationStatus.authenticated) {
          router.go(RoutePaths.home.asRoutePath);
        }
      },
    );
  }

  BlocListener<ServiceUnavailableBloc, ServiceUnavailableState> _serviceUnavailableBlocListener() {
    return BlocListener<ServiceUnavailableBloc, ServiceUnavailableState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ServiceUnavailableStatus.serviceUnavailable) {
          router.go(RoutePaths.serviceUnavailable.asRoutePath);
        }
      },
    );
  }
}
