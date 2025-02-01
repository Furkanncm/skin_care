part of 'service_unavailable_bloc.dart';

enum ServiceUnavailableStatus { unknown, serviceUnavailable }

@immutable
final class ServiceUnavailableState extends Equatable {
  const ServiceUnavailableState({this.status = ServiceUnavailableStatus.unknown});

  final ServiceUnavailableStatus status;

  @override
  List<Object> get props => [
        status,
      ];

  ServiceUnavailableState copyWith({
    ServiceUnavailableStatus? status,
  }) {
    return ServiceUnavailableState(
      status: status ?? this.status,
    );
  }
}
