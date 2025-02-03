import 'package:bloc_clean_architecture/src/common/routing/router.dart';
import 'package:flutter/material.dart';

abstract class SCToasts {
  static void showSuccessToast({String? message}) => overlayManager.showToast(
        message: message,
        messageMaxLines: 20,
        messageStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        backgroundColor: Colors.green.shade400,
        shadowColor: Colors.black12,
        leading: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      );

  static void showInfoToast({String? message}) => overlayManager.showToast(
        message: message,
        messageMaxLines: 20,
        messageStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        backgroundColor: Colors.blue.shade400,
        shadowColor: Colors.black12,
        leading: const Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
      );

  static void showWarningToast({String? message}) => overlayManager.showToast(
        message: message,
        messageMaxLines: 20,
        messageStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        backgroundColor: Colors.orange.shade400,
        shadowColor: Colors.black12,
        leading: const Icon(
          Icons.warning_amber_outlined,
          color: Colors.white,
        ),
      );

  static void showErrorToast({String? message}) => overlayManager.showToast(
        message: message,
        messageStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        messageMaxLines: 20,
        backgroundColor: Colors.red.shade400,
        shadowColor: Colors.black12,
        leading: const Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      );
}
