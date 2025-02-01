import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/domain/network_manager/network_manager_repository.dart';
import 'package:flutter_core/flutter_core.dart';

extension FutureBaseResponseExtension<T> on Future<BaseResponse<T>> {
  Future<BaseResponse<T>> intercept({
    bool showSuccessMessage = true,
    bool showErrorMessage = true,
  }) async {
    final networkManagerRepository = getIt<NetworkManagerRepository>();

    final result = await this;

    if (result.error.isNull && showSuccessMessage) {
      networkManagerRepository.addSuccessResponse(result);
    } else if (result.error.isNotNull && showErrorMessage) {
      networkManagerRepository.addErrorResponse(result);
    }

    return result;
  }
}
