part of 'network_manager_bloc.dart';

sealed class NetworkManagerEvent extends Equatable {
  const NetworkManagerEvent();

  @override
  List<Object> get props => [];
}

class _NetworkManagerSuccessArrivedEvent extends NetworkManagerEvent {
  const _NetworkManagerSuccessArrivedEvent(this.baseResponse);
  final BaseResponse<dynamic> baseResponse;

  @override
  List<Object> get props => [baseResponse];
}

class _NetworkManagerErrorArrivedEvent extends NetworkManagerEvent {
  const _NetworkManagerErrorArrivedEvent(this.baseResponse);
  final BaseResponse<dynamic> baseResponse;

  @override
  List<Object> get props => [baseResponse];
}
