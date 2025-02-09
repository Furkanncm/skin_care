import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
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
      title: CoreText.titleLarge(LocalizationKey.addNewProduct.value),
      centerTitle: true,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          height: context.width * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              bloc.state.image != null ? Image.file(bloc.state.image!, width: context.width * 0.3, height: context.width * 0.3, fit: BoxFit.cover) : Icon(Icons.photo_album_outlined, size: context.width * 0.2, color: Colors.grey.shade700),
              verticalBox8,
              bloc.state.image != null ? emptyBox : CoreText.bodySmall(LocalizationKey.addPhoto.value),
            ],
          ),
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
          validator: (value) => value!.isEmpty ? LocalizationKey.cantEmptyName.value : null,
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
          validator: (value) {
            return context.watch<AddCosmeticBloc>().state.selectedCategory == null
                ? LocalizationKey.chooseCategory.value // Kategori seçilmemişse hata göster
                : null;
          },
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
    final colorSheme = context.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoreText.bodyMedium(LocalizationKey.color.value),
        verticalBox8,
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => value!.isEmpty ? LocalizationKey.cantEmptyColor.value : null,
          controller: bloc.colorController,
          onTap: () async {
            final selectedColor = await SCBottomSheets.showSingleSelectBottomSheet<ColorCategory>(
              context: context,
              items: ColorCategory.getColorCategories(),
              selected: bloc.state.selectedColor,
              title: LocalizationKey.pickColor.value,
            );
            if (selectedColor == null) return;
            bloc.add(AddCosmeticSelectColorEvent(selectedColor: selectedColor));
          },
          readOnly: true,
          decoration: InputDecoration(
            fillColor: selectedColor?.name == null ? colorSheme.surface : selectedColor?.hexToColor(selectedColor.hexCode ?? ''),
            suffixIcon: Icon(Icons.arrow_drop_down),
            prefixIcon: const Icon(Icons.color_lens_outlined),
            hintStyle: TextStyle(color: selectedColor?.name == null ? Colors.grey : colorSheme.onSurface),
            hintText: selectedColor?.name ?? LocalizationKey.pickColor.value,
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
          validator: (value) => value!.isEmpty ? LocalizationKey.cantEmptyDescription.value : null,
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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => context.read<AddCosmeticBloc>().add(const AddCosmeticSaveButtonPressedEvent()),
        icon: const Icon(Icons.save),
        label: CoreText.bodyMedium(LocalizationKey.save.value),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
