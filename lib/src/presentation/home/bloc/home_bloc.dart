import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/enums/firestore_collection.dart';
import 'package:bloc_clean_architecture/src/data/model/plan/plan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/cosmetic/cosmetic.dart';
import '../../../data/model/my_user/my_user.dart';
import '../../../domain/user/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._userRepository) : super(HomeState()) {
    on<HomeInitializedEvent>(_initialize);
    on<HomeDayChangedEvent>(_homeDayChangedEvent);
    on<HomeBackToTodayEvent>(_homeBackToTodayEvent);
    on<HomePageChangedOnCalendar>(_homePageChangedOnCalendar);
  }

  bool isDayInWeek = true;
  final UserRepository _userRepository;

  /// Bu metod, bugünkü planı çekiyor
  Future<void> _initialize(HomeEvent event, Emitter<HomeState> emit) async {
    final user = await _userRepository.getLocalUser();
    if (user == null) return;
    final routineDocId = DateTime.now().toddMMy.toString();
    final routineRef = FirebaseFirestore.instance
        .collection(FirestoreCollection.users.value)
        .doc(user.id)
        .collection("routines")
        .doc(routineDocId);

    // Sabaha ait kozmetik verilerini çekiyoruz
    final morningSnapshot = await routineRef.collection("morning").get();
    // Akşam planınız varsa çekmek için:
    final eveningSnapshot = await routineRef.collection("evening").get();

    final morningCosmetics =
        morningSnapshot.docs.map((doc) => Cosmetic.fromJson(doc.data())).toList();
    final eveningCosmetics =
        eveningSnapshot.docs.map((doc) => Cosmetic.fromJson(doc.data())).toList();

    // Plan modelinizin yapısına göre, örneğin; planın sabah ve akşam kısımlarını ayrı nesneler olarak tanımlayabilirsiniz.
    final todaysPlan = Plan(
      date: routineDocId,
      morning: RoutinePart(cosmetics: morningCosmetics),
      evening: RoutinePart(cosmetics: eveningCosmetics),
    );

    emit(state.copyWith(
      status: HomeStatus.success,
      currentDay: DateTime.now(),
      user: user,
      todaysPlan: todaysPlan,
    ));
  }

  /// Takvimden farklı bir gün seçildiğinde o güne ait planı çekiyoruz.
  Future<void> _homeDayChangedEvent(HomeDayChangedEvent event, Emitter<HomeState> emit) async {
    if (state.user == null) return;
    final routineDocId = event.currentDay.toddMMy.toString();
    final routineRef = FirebaseFirestore.instance
        .collection(FirestoreCollection.users.value)
        .doc(state.user!.id)
        .collection("routines")
        .doc(routineDocId);

    final morningSnapshot = await routineRef.collection("morning").get();
    final eveningSnapshot = await routineRef.collection("evening").get();

    final morningCosmetics =
        morningSnapshot.docs.map((doc) => Cosmetic.fromJson(doc.data())).toList();
    final eveningCosmetics =
        eveningSnapshot.docs.map((doc) => Cosmetic.fromJson(doc.data())).toList();

    final plan = Plan(
      date: routineDocId,
      morning: RoutinePart(cosmetics: morningCosmetics),
      evening: RoutinePart(cosmetics: eveningCosmetics),
    );

    emit(state.copyWith(
      currentDay: event.currentDay,
      todaysPlan: plan,
    ));
    isDayInWeek = isDayInWeekFunc(event.currentDay);
  }

  Future<void> _homeBackToTodayEvent(HomeBackToTodayEvent event, Emitter<HomeState> emit) async {
    final focusedDay = DateTime.now();
    final routineDocId = focusedDay.toddMMy.toString();
    final routineRef = FirebaseFirestore.instance
        .collection(FirestoreCollection.users.value)
        .doc(state.user!.id)
        .collection("routines")
        .doc(routineDocId);

    final morningSnapshot = await routineRef.collection("morning").get();
    final eveningSnapshot = await routineRef.collection("evening").get();

    final morningCosmetics =
        morningSnapshot.docs.map((doc) => Cosmetic.fromJson(doc.data())).toList();
    final eveningCosmetics =
        eveningSnapshot.docs.map((doc) => Cosmetic.fromJson(doc.data())).toList();

    final plan = Plan(
      date: routineDocId,
      morning: RoutinePart(cosmetics: morningCosmetics),
      evening: RoutinePart(cosmetics: eveningCosmetics),
    );

    emit(state.copyWith(
      focusedDay: focusedDay,
      todaysPlan: plan,
      currentDay: focusedDay,
    ));
    isDayInWeek = isDayInWeekFunc(focusedDay);
  }

  Future<void> _homePageChangedOnCalendar(HomePageChangedOnCalendar event, Emitter<HomeState> emit) async {
    isDayInWeek = isDayInWeekFunc(event.focusedDay);
    emit(state.copyWith(focusedDay: event.focusedDay, currentDay: DateTime.now()));
  }

  bool isDayInWeekFunc(DateTime currentDay) {
    final now = DateTime.now();
    final beginningOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = beginningOfWeek.add(Duration(days: 6));

    return currentDay.isAfter(beginningOfWeek.subtract(const Duration(days: 1))) &&
        currentDay.isBefore(endOfWeek.add(const Duration(seconds: 1)));
  }
}
