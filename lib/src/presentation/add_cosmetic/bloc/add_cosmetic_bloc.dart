import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/routing/router.dart';
import 'package:bloc_clean_architecture/src/data/model/color_category/color_category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/skincare_category/skincare_category.dart';

part 'add_cosmetic_event.dart';
part 'add_cosmetic_state.dart';

@injectable
class AddCosmeticBloc extends Bloc<AddCosmeticEvent, AddCosmeticState> {
  AddCosmeticBloc() : super(const AddCosmeticState()) {
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

  Future<void> _onInitialized(AddCosmeticInitializedEvent event, Emitter<AddCosmeticState> emit) async {
    emit(state.copyWith(status: AddCosmeticStatus.loaded));
  }

  Future<void> _addCosmeticSelectCategoryEvent(AddCosmeticSelectCategoryEvent event, Emitter<AddCosmeticState> emit) async {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }

  Future<void> _addCosmeticSelectColorEvent(AddCosmeticSelectColorEvent event, Emitter<AddCosmeticState> emit) async {
    emit(state.copyWith(selectedColor: event.selectedColor));
  }

  Future<void> _addCosmeticSaveButtonPressedEvent(AddCosmeticSaveButtonPressedEvent event, Emitter<AddCosmeticState> emit) async {
    if (!(formKey.currentState!.validate())) return;
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
