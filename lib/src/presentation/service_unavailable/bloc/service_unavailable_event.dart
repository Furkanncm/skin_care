part of 'service_unavailable_bloc.dart';

sealed class ServiceUnavailableEvent extends Equatable {
  const ServiceUnavailableEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class _ServiceUnavailableStateChangedEvent extends ServiceUnavailableEvent {
  const _ServiceUnavailableStateChangedEvent(this.serviceUnavailableState);

  final ServiceUnavailableState serviceUnavailableState;

  @override
  List<Object> get props => [serviceUnavailableState];
}
