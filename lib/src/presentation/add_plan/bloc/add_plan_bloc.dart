import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/dialogs/sc_dialogs.dart';
import 'package:bloc_clean_architecture/src/common/enums/firestore_collection.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

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
    print(snapshot.docs.map((e) => Cosmetic.fromJson(e.data())).length);
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
      updatedList.add(event.cosmetic);
    }
    emit(state.copyWith(addedCosmetics: updatedList));
  }

  Future<void> _addPlanSubmitPlansEvent(AddPlanSubmitPlansEvent event, Emitter<AddPlanState> emit) async {
    final planRef = await FirebaseFirestore.instance.collection(FirestoreCollection.users.name).doc(state.user?.id).collection(FirestoreCollection.plans.name).doc(state.selectedDate!.toddMMy.toString());

    final existingPlan = await planRef.get();
    if (existingPlan.exists) {
      SCDialogs.showDeletionConfirmationDialog(
          onDelete: () async {
            await planRef.set(
              {
                'cosmetics': state.addedCosmetics?.map((e) => e.toJson()).toList() ?? [],
                'isMorning': state.isMorning,
                'isEvening': state.isEvening,
              },
              SetOptions(merge: false),
            );
          },
          context: event.context);
      return;
    }
  }
}
