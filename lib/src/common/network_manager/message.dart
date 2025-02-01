import 'package:flutter/material.dart';

enum MessageType {
  error,
  warning,
  info,
  success;

  static MessageType? fromString(String? type) {
    return switch (type) {
      'error' => MessageType.error,
      'warning' => MessageType.warning,
      'info' => MessageType.info,
      'success' => MessageType.success,
      _ => null,
    };
  }
}

@immutable
class Message {
  const Message({
    this.type,
    this.content,
  });
  final MessageType? type;
  final String? content;

  Message fromJson(Map<String, dynamic> json) {
    return Message(
      type: json['type'] as MessageType?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'content': content,
    };
  }

  Message copyWith({
    MessageType? type,
    String? content,
  }) {
    return Message(
      type: type ?? this.type,
      content: content ?? this.content,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Message && other.type == type && other.content == content;
  }

  @override
  int get hashCode => type.hashCode ^ content.hashCode;
}
