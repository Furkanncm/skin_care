part of 'network_manager_bloc.dart';

sealed class NetworkManagerState {
  const NetworkManagerState({
    this.baseResponse,
  });

  final BaseResponse<dynamic>? baseResponse;
}

final class NetworkManagerInitial extends NetworkManagerState {}

final class NetworkManagerSuccess extends NetworkManagerState {
  const NetworkManagerSuccess({required super.baseResponse});
}

final class NetworkManagerError extends NetworkManagerState {
  const NetworkManagerError({required super.baseResponse});
}
