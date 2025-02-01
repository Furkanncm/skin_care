import 'dart:async';

import 'package:bloc_clean_architecture/src/presentation/shared_blocs/sqflite_manager/bloc/manager/sqflite_manager_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

abstract interface class ISqfliteManagerRepository {
  void addSuccessResult(BaseResult<dynamic> baseResult);

  void addErrorResult(BaseResult<dynamic> baseResult);
}

@lazySingleton
final class SqfliteManagerRepository extends ISqfliteManagerRepository {
  final StreamController<SqfliteManagerState> _controller = StreamController<SqfliteManagerState>();

  Stream<SqfliteManagerState> get status async* {
    yield* _controller.stream;
  }

  @override
  void addSuccessResult(BaseResult<dynamic> baseResult) {
    _controller.add(SqfliteManagerSuccess(baseResult: baseResult));
  }

  @override
  void addErrorResult(BaseResult<dynamic> baseResult) {
    _controller.add(SqfliteManagerError(baseResult: baseResult));
  }

  void dispose() {
    _controller.close();
  }
}
