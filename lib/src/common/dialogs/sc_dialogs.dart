import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

abstract class SCDialogs {
  static Future<void> showDeletionConfirmationDialog({required VoidCallback onDelete, required BuildContext context}) {
    final id = UniqueKey().toString();

    return popupManager.showDefaultAdaptiveAlertDialog<void>(
      id: id,
      context: context,
      title: CoreText.titleMedium(LocalizationKey.thereIsAPlanForThatDay.value),
      content: CoreText.bodyMedium(LocalizationKey.youSureUpdate.value),
      okButtonLabel: LocalizationKey.ok.tr(context, listen: false),
      cancelButtonLabel: LocalizationKey.giveUp.tr(context, listen: false),
      reversedActions: true,
      isDestuctiveOkButtonIOS: true,
      onOkButtonPressed: () {
        popupManager.hidePopup<void>(id: id);
        onDelete();
      },
    );
  }

  static Future<void> showErrorMessageDialog({required String message, required BuildContext context}) {
    final id = UniqueKey().toString();

    return popupManager.showAdaptiveInfoDialog(
      id: id,
      context: context,
      title: CoreText(LocalizationKey.error.tr(context, listen: false)),
      content: CoreText(message),
      okButtonLabel: LocalizationKey.ok.tr(context, listen: false),
    );
  }

  static Future<void> showWarningMessageDialog({required String message, required BuildContext context}) {
    final id = UniqueKey().toString();

    return popupManager.showAdaptiveInfoDialog(
      id: id,
      context: context,
      title: CoreText(LocalizationKey.warning.value),
      content: CoreText(message),
      okButtonLabel: LocalizationKey.ok.tr(context, listen: false),
    );
  }

  static Future<bool?> showLogoutDialog({required BuildContext context}) {
    final id = UniqueKey().toString();
    return popupManager.showDefaultAdaptiveAlertDialog<bool>(
      id: id,
      context: context,
      title: CoreText.bodyLarge(LocalizationKey.logout.tr(context, listen: false)),
      content: CoreText.bodyLarge(LocalizationKey.logoutConfirmation.tr(context, listen: false)),
      onOkButtonPressed: () => popupManager.hidePopup(id: id, result: true),
      isDestuctiveOkButtonIOS: true,
      isDefaultOkButtonIOS: true,
    );
  }

  static Future<DateTime?> showDatePickerDialog({
    required BuildContext context,
    required DateTime initialDate,
  }) {
    final id = UniqueKey().toString();
    return popupManager.showAdaptiveDatePicker(
      id: id,
      context: context,
      initialDateTime: initialDate,
      minimumDate: DateTime.utc(2010, 10, 16),
      maximumDate: DateTime.utc(2030, 3, 14),
    );
  }
}
