import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:bloc_clean_architecture/src/common/routing/router.dart';
import 'package:bloc_clean_architecture/src/common/toasts/my_toasts.dart';
import 'package:bloc_clean_architecture/src/data/model/color_category/color_category.dart';
import 'package:bloc_clean_architecture/src/data/model/cosmetic/cosmetic.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../common/enums/firestore_collection.dart';
import '../../../data/model/skincare_category/skincare_category.dart';

part 'add_cosmetic_event.dart';
part 'add_cosmetic_state.dart';

@injectable
class AddCosmeticBloc extends Bloc<AddCosmeticEvent, AddCosmeticState> {
  AddCosmeticBloc(this._userRepository) : super(const AddCosmeticState()) {
    on<AddCosmeticInitializedEvent>(_onInitialized);
    on<AddCosmeticSelectCategoryEvent>(_addCosmeticSelectCategoryEvent);
    on<AddCosmeticSelectColorEvent>(_addCosmeticSelectColorEvent);
    on<AddCosmeticSaveButtonPressedEvent>(_addCosmeticSaveButtonPressedEvent);
    on<AddCosmeticPickImageEvent>(_addCosmeticPickImageEvent);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  bool isPhotoSelected = false;
  final UserRepository _userRepository;

  Future<void> _onInitialized(AddCosmeticInitializedEvent event, Emitter<AddCosmeticState> emit) async {
    emit(state.copyWith(status: AddCosmeticStatus.loaded));
  }

  Future<void> _addCosmeticSelectCategoryEvent(AddCosmeticSelectCategoryEvent event, Emitter<AddCosmeticState> emit) async {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
    formKey.currentState?.validate();
  }

  Future<void> _addCosmeticSelectColorEvent(AddCosmeticSelectColorEvent event, Emitter<AddCosmeticState> emit) async {
    emit(state.copyWith(selectedColor: event.selectedColor));
    formKey.currentState?.validate();
  }

  Future<void> _addCosmeticSaveButtonPressedEvent(AddCosmeticSaveButtonPressedEvent event, Emitter<AddCosmeticState> emit) async {
    if (!(formKey.currentState!.validate())) return;
    final user = _userRepository.getLocalUser();
    final cosmetic = Cosmetic(
      name: nameController.text,
      description: descriptionController.text,
      category: state.selectedCategory?.name,
      color: state.selectedColor?.hexCode,
      image: state.image?.path,
      isEvening: false,
      isMorning: false,
    );
    try {
      await FirebaseFirestore.instance.collection(FirestoreCollection.users.value).doc(user?.id ?? "").collection(FirestoreCollection.cosmetics.value).add(cosmetic.toJson()).withIndicator();
      SCToasts.showSuccessToast(message: LocalizationKey.productAddedSuccessfully.value);
    } catch (e) {
      SCToasts.showWarningToast(message: LocalizationKey.productCouldNotBeAdded.value);
    }
  }

  Future<void> _addCosmeticPickImageEvent(AddCosmeticPickImageEvent event, Emitter<AddCosmeticState> emit) async {
    final pickedFile = await picker.pickImage(source: event.source);
    if (pickedFile != null) {
      emit(state.copyWith(image: File(pickedFile.path)));
      isPhotoSelected = true;
      router.pop();
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    categoryController.dispose();
    colorController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
