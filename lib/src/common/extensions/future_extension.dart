import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/domain/indicator/indicator_repository.dart';

extension FutureExtension<T> on Future<T> {
  Future<T> withIndicator() async {
    final indicatorRepository = getIt<IndicatorRepository>();

    try {
      indicatorRepository.show();
      final result = await this;
      indicatorRepository.hide();
      return result;
    } catch (e) {
      indicatorRepository.hide();
      rethrow;
    }
  }
}
