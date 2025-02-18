import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/enums/firestore_collection.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../../../common/localization/localization_key.dart';
import '../../../common/toasts/my_toasts.dart';
import '../../../data/model/cosmetic/cosmetic.dart';

part 'add_plan_event.dart';
part 'add_plan_state.dart';

@injectable
class AddPlanBloc extends Bloc<AddPlanEvent, AddPlanState> {
  AddPlanBloc(this._userRepository) : super(AddPlanState()) {
    on<AddPlanInitialEvent>(_addPlanInitialEvent);
    on<AddPlanSelectDateEvent>(_addPlanSelectDateEvent);
    on<AddPlanIsMorningEvent>(_addPlanIsMorningEvent);
    on<AddPlanIsEveningEvent>(_addPlanIsEveningEvent);
    on<AddPlanAddCosmeticEvent>(_addPlanAddCosmeticEvent);
    on<AddPlanSubmitPlansEvent>(_addPlanSubmitPlansEvent);
  }

  final UserRepository _userRepository;
  Future<void> _addPlanInitialEvent(AddPlanInitialEvent event, Emitter<AddPlanState> emit) async {
    final user = await _userRepository.getLocalUser();
    final snapshot = await FirebaseFirestore.instance.collection(FirestoreCollection.users.name).doc(user!.id).collection(FirestoreCollection.cosmetics.name).get();
    emit(
      state.copyWith(
        cosmetics: snapshot.docs.map((e) => Cosmetic.fromJson(e.data())).toList(),
        selectedDate: DateTime.now(),
        status: AddPlanStatus.loaded,
        user: user,
      ),
    );
  }

  Future<void> _addPlanIsMorningEvent(AddPlanIsMorningEvent event, Emitter<AddPlanState> emit) async {
    emit(state.copyWith(isMorning: event.isMorning));
  }

  Future<void> _addPlanIsEveningEvent(AddPlanIsEveningEvent event, Emitter<AddPlanState> emit) async {
    emit(state.copyWith(isEvening: event.isEvening));
  }

  Future<void> _addPlanSelectDateEvent(AddPlanSelectDateEvent event, Emitter<AddPlanState> emit) async {
    emit(state.copyWith(selectedDate: event.date));
  }

  Future<void> _addPlanAddCosmeticEvent(AddPlanAddCosmeticEvent event, Emitter<AddPlanState> emit) async {
    final updatedList = List<Cosmetic>.from(state.addedCosmetics ?? []);
    if (updatedList.contains(event.cosmetic)) {
      updatedList.remove(event.cosmetic);
    } else {
      final oldCosmetic = event.cosmetic;
      final cosmetic = Cosmetic().copyWith(
        id: oldCosmetic.id,
        name: oldCosmetic.name,
        category: oldCosmetic.category,
        image: oldCosmetic.image,
        description: oldCosmetic.description,
        color: oldCosmetic.color,
        isMorning: state.isMorning,
        isEvening: state.isEvening,
      );
      updatedList.add(cosmetic);
    }
    emit(state.copyWith(addedCosmetics: updatedList));
  }

  Future<void> _addPlanSubmitPlansEvent(AddPlanSubmitPlansEvent event, Emitter<AddPlanState> emit) async {
    // "plans" yerine artık "routines" koleksiyonunu kullanıyoruz.
    final routineRef = FirebaseFirestore.instance
        .collection(FirestoreCollection.users.name)
        .doc(state.user?.id)
        .collection("routines") // FirestoreCollection.routines tanımlı değilse direkt string kullanabilirsiniz.
        .doc(state.selectedDate!.toddMMy.toString());

    try {
      // Eğer sabah rutini seçildiyse, eklenen her kozmeti ayrı belge olarak morning alt koleksiyonuna ekle
      if (state.isMorning) {
        for (final cosmetic in state.addedCosmetics ?? []) {
          await routineRef
              .collection("morning")
              .doc(cosmetic.id) // Kozmetik id'sini belge id'si olarak kullanıyoruz
              .set({
            'date': state.selectedDate!.toddMMy.toString(),
            ...cosmetic.toJson(),
          }, SetOptions(merge: true));
        }
      }

      // Eğer akşam rutini seçildiyse, eklenen her kozmeti ayrı belge olarak evening alt koleksiyonuna ekle
      if (state.isEvening) {
        for (final cosmetic in state.addedCosmetics ?? []) {
          await routineRef.collection("evening").doc(cosmetic.id).set({
            'date': state.selectedDate!.toddMMy.toString(),
            ...cosmetic.toJson(),
          }, SetOptions(merge: true)).withIndicator();
        }
      }

      SCToasts.showSuccessToast(message: LocalizationKey.planAddedSuccesfully.value);
    } catch (e) {
      SCToasts.showWarningToast(message: LocalizationKey.planCanNotSuccesfully.value);
    }
  }
}
