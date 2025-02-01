import 'dart:async';

import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/network_manager/bloc/manager/network_manager_bloc.dart';
import 'package:injectable/injectable.dart';

abstract interface class INetworkManagerRepository {
  void addSuccessResponse(BaseResponse<dynamic> baseResponse);

  void addErrorResponse(BaseResponse<dynamic> baseResponse);
}

@lazySingleton
final class NetworkManagerRepository extends INetworkManagerRepository {
  final StreamController<NetworkManagerState> _controller = StreamController<NetworkManagerState>();

  Stream<NetworkManagerState> get status async* {
    yield* _controller.stream;
  }

  @override
  void addSuccessResponse(BaseResponse<dynamic> baseResponse) {
    _controller.add(NetworkManagerSuccess(baseResponse: baseResponse));
  }

  @override
  void addErrorResponse(BaseResponse<dynamic> baseResponse) {
    _controller.add(NetworkManagerError(baseResponse: baseResponse));
  }

  void dispose() {
    _controller.close();
  }
}
