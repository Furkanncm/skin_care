import 'dart:async';

import 'package:bloc_clean_architecture/src/presentation/service_unavailable/bloc/service_unavailable_bloc.dart';
import 'package:injectable/injectable.dart';

mixin IServiceUnavailableRepository {
  void onServiceUnavailable();
}

@lazySingleton
final class ServiceUnavailableRepository implements IServiceUnavailableRepository {
  ServiceUnavailableRepository();

  final StreamController<ServiceUnavailableState> _controller = StreamController<ServiceUnavailableState>();

  Stream<ServiceUnavailableState> get status async* {
    yield* _controller.stream;
  }

  @override
  void onServiceUnavailable() {
    _controller.add(const ServiceUnavailableState(status: ServiceUnavailableStatus.serviceUnavailable));
  }

  void dispose() {
    _controller.close();
  }
}
