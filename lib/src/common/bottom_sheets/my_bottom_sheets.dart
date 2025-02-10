import 'package:bloc_clean_architecture/src/presentation/add_cosmetic/bloc/add_cosmetic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:image_picker/image_picker.dart';

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

  static Future<T?> showImagePickerBottomSheet<T>({
    required BuildContext context,
    required AddCosmeticBloc bloc,
  }) {
    return popupManager.showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              verticalBox12,
              Divider(indent: context.width / 3, endIndent: context.width / 3),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(LocalizationKey.takePhotoFromCamera.value),
                onTap: () {
                  bloc.add(AddCosmeticPickImageEvent(source: ImageSource.camera));
                },
              ),
              verticalBox8,
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text(LocalizationKey.choosePhotoFromGallery.value),
                onTap: () {
                  bloc.add(AddCosmeticPickImageEvent(source: ImageSource.gallery));
                },
              ),
              verticalBox8,
            ],
          ),
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
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(context.colorScheme.primary),
        ),
      ),
      child: child,
    );
  }
}
