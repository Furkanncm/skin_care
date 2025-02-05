import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

import '../localization/localization_key.dart';
import '../routing/router.dart';

abstract class SCBottomSheets {
  static Future<T?> showSingleSelectBottomSheet<T extends SelectableSearchMixin>({
    required BuildContext context,
    required List<T> items,
    T? selected,
    String? title,
  }) {
    return popupManager.singleSelectableSearchSheet(
      selected: selected,
      title: title ?? LocalizationKey.suggestionFieldToBeCorrected.value,
      context: context,
      showDragHandle: true,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      items: items,
      builder: (context, child) {
        return EditFieldBottomSheetTheme(
          child: child,
        );
      },
    );
  }
}

@immutable
final class EditFieldBottomSheetTheme extends StatelessWidget {
  const EditFieldBottomSheetTheme({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: context.textTheme.headlineSmall,
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(context.colorScheme.primary),
        ),
      ),
      child: child,
    );
  }
}
