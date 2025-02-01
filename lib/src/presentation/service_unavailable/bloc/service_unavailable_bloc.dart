import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/domain/service_unavailable/service_unavailable_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'service_unavailable_event.dart';
part 'service_unavailable_state.dart';

@lazySingleton
class ServiceUnavailableBloc extends Bloc<ServiceUnavailableEvent, ServiceUnavailableState> {
  ServiceUnavailableBloc(this._serviceUnavailableRepository) : super(const ServiceUnavailableState()) {
    on<_ServiceUnavailableStateChangedEvent>(_serviceUnavailableStateChanged);

    _serviceUnavailableRepository.status.listen((state) {
      add(_ServiceUnavailableStateChangedEvent(state));
    });
  }

  final ServiceUnavailableRepository _serviceUnavailableRepository;

  void _serviceUnavailableStateChanged(_ServiceUnavailableStateChangedEvent event, Emitter<ServiceUnavailableState> emit) {
    emit(
      state.copyWith(
        status: event.serviceUnavailableState.status,
      ),
    );
  }
}
