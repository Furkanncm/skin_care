import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/data/model/color_category/color_category.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/skincare_category/skincare_category.dart';

part 'add_cosmetic_event.dart';
part 'add_cosmetic_state.dart';

@injectable
class AddCosmeticBloc extends Bloc<AddCosmeticEvent, AddCosmeticState> {
  AddCosmeticBloc() : super(const AddCosmeticState()) {
    on<AddCosmeticInitializedEvent>(_onInitialized);
    on<AddCosmeticSelectCategoryEvent>(_addCosmeticSelectCategoryEvent);
  }

  Future<void> _onInitialized(AddCosmeticInitializedEvent event, Emitter<AddCosmeticState> emit) async {
    emit(state.copyWith(status: AddCosmeticStatus.loaded));
  }

  Future<void> _addCosmeticSelectCategoryEvent(AddCosmeticSelectCategoryEvent event, Emitter<AddCosmeticState> emit) async {
    emit(state.copyWith(selectedCategory: event.selectedCategory));
  }
}
