import 'package:flutter_core/flutter_core.dart';

enum RequestPath implements BaseRequestPath {
  login('/login'),
  posts('/posts'),
  comments('/comments'),
  cultures('/cultures'),
  ;

  const RequestPath(this.value);

  final String value;

  @override
  String get asString => value;
}
