import 'package:bloc_clean_architecture/src/common/network_manager/message.dart';
import 'package:flutter_core/flutter_core.dart';

final class BaseResponse<T> extends CoreBaseResponse {
  const BaseResponse({
    this.data,
    this.succeeded,
    this.messages,
    this.statusCode,
    this.error,
  });

  final T? data;
  final bool? succeeded;
  final List<Message>? messages;
  final int? statusCode;
  final Object? error;
}
