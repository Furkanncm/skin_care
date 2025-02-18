import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/dialogs/sc_dialogs.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/widgets/adaptive_indicator/adaptive_indicator.dart';
import 'package:bloc_clean_architecture/src/data/model/color_category/color_category.dart';
import 'package:bloc_clean_architecture/src/presentation/add_cosmetic/bloc/add_cosmetic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../common/bottom_sheets/my_bottom_sheets.dart';
import '../../../data/model/skincare_category/skincare_category.dart';

@immutable
final class AddCosmeticView extends StatelessWidget {
  const AddCosmeticView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddCosmeticBloc>()..add(const AddCosmeticInitializedEvent()),
      child: BlocBuilder<AddCosmeticBloc, AddCosmeticState>(
        builder: (context, state) {
          if (state.status == AddCosmeticStatus.loading) const Center(child: AdaptiveIndicator());
          return Scaffold(
            appBar: _AppBar(),
            body: _Body(),
          );
        },
      ),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CoreText.headlineMedium(LocalizationKey.addNewProduct.value),
      centerTitle: true,
      backgroundColor: context.colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.paddingConstants.pagePadding,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _PhotoCard(),
            verticalBox24,
            const Divider(),
            verticalBox24,
            Form(
              key: context.read<AddCosmeticBloc>().formKey,
              child: Column(
                children: [
                  _NameField(),
                  verticalBox8,
                  _CategoryField(),
                  verticalBox8,
                  _ColorField(),
                  verticalBox8,
                  _DescriptionField(),
                ],
              ),
            ),
            verticalBox24,
            _SaveButton(),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _PhotoCard extends StatelessWidget {
  _PhotoCard();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddCosmeticBloc>();
    return GestureDetector(
      onTap: () => SCBottomSheets.showImagePickerBottomSheet(context: context, bloc: bloc),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
          ),
          child: bloc.state.image != null
              ? Padding(
                  padding: AppConstants.paddingConstants.pagePadding,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      bloc.state.image!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.photo_album_outlined, size: 100, color: Colors.grey);
                      },
                    ),
                  ),
                )
              : const Icon(Icons.photo_album_outlined, size: 60, color: Colors.grey),
        ),
      ),
    );
  }
}

@immutable
final class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoreText.bodyMedium(LocalizationKey.name.value),
        verticalBox8,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => (value?.isEmpty ?? true) ? LocalizationKey.cantEmptyName.value : null,
          controller: context.read<AddCosmeticBloc>().nameController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.label_outline),
            hintStyle: TextStyle(color: Colors.grey),
            hintText: LocalizationKey.name.value,
          ),
        ),
      ],
    );
  }
}

@immutable
final class _CategoryField extends StatelessWidget {
  const _CategoryField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddCosmeticBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoreText.bodyMedium(LocalizationKey.category.value),
        verticalBox8,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => bloc.state.selectedCategory == null ? LocalizationKey.chooseCategory.value : null,
          controller: bloc.categoryController,
          onTap: () async {
            final selectedCategory = await SCBottomSheets.showSingleSelectBottomSheet<SkinCareCategory>(
              context: context,
              items: SkinCareCategory.getSkincareCategories(),
              title: LocalizationKey.chooseCategory.value,
            );
            if (selectedCategory == null) return;
            bloc.add(AddCosmeticSelectCategoryEvent(selectedCategory: selectedCategory));
          },
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.arrow_drop_down),
            prefixIcon: const Icon(Icons.face_retouching_natural),
            hintStyle: TextStyle(color: bloc.state.selectedCategory?.name == null ? Colors.grey : context.colorScheme.onSurface),
            hintText: bloc.state.selectedCategory?.name ?? LocalizationKey.chooseCategory.value,
          ),
        ),
      ],
    );
  }
}

@immutable
final class _ColorField extends StatelessWidget {
  const _ColorField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddCosmeticBloc>();
    final selectedColor = bloc.state.selectedColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoreText.bodyMedium(LocalizationKey.color.value),
        verticalBox8,
        GestureDetector(
          onTap: () async {
            final selected = await SCBottomSheets.showSingleSelectBottomSheet<ColorCategory>(
              context: context,
              items: ColorCategory.getColorCategories(),
              selected: bloc.state.selectedColor,
              title: LocalizationKey.pickColor.value,
            );
            if (selected == null) return;
            bloc.add(AddCosmeticSelectColorEvent(selectedColor: selected));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: selectedColor?.hexToColor(selectedColor.hexCode ?? '') ?? Colors.grey,
                      radius: 12,
                    ),
                    horizontalBox12,
                    CoreText.bodyMedium(
                      selectedColor?.name ?? LocalizationKey.pickColor.value,
                      textColor: selectedColor != null ? Colors.black : Colors.grey,
                    ),
                  ],
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

@immutable
final class _DescriptionField extends StatelessWidget {
  const _DescriptionField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoreText.bodyMedium(LocalizationKey.description.value),
        verticalBox8,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => (value?.isEmpty ?? true) ? LocalizationKey.cantEmptyDescription.value : null,
          controller: context.read<AddCosmeticBloc>().descriptionController,
          maxLines: 4,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.description_outlined),
            hintStyle: TextStyle(color: Colors.grey),
            hintText: LocalizationKey.descriptionForCosmetic.value,
          ),
        ),
      ],
    );
  }
}

@immutable
final class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddCosmeticBloc>();
    return SizedBox(
      width: double.infinity,
      child: CoreOutlinedButton.autoIndicator(
        onPressed: () {
          if (bloc.state.image == null) {
            SCDialogs.showWarningMessageDialog(context: context, message: LocalizationKey.mustPickAPhoto.value);
            return;
          }
          bloc.add(const AddCosmeticSaveButtonPressedEvent());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save),
            horizontalBox8,
            CoreText.bodyLarge(LocalizationKey.save.value),
          ],
        ),
      ),
    );
  }
}
