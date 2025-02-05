import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/my_user/my_user.dart';
import '../../../domain/auth/auth_repository.dart';
import '../../../domain/user/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._authRepository, this._userRepository) : super(HomeState()) {
    on<HomeInitializedEvent>(_initialize);
    on<HomeDayChangedEvent>(_homeDayChangedEvent);
    on<HomeBackToTodayEvent>(_homeBackToTodayEvent);
    on<HomePageChangedOnCalendar>(_homePageChangedOnCalendar);
  }

  bool isDayInWeek = true;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  Future<void> _initialize(HomeEvent event, Emitter<HomeState> emit) async {
 


//    await FirebaseFirestore.instance
//       .collection('users')
//       .doc("1")
//       .collection('plans')
//       .doc(DateTime.now().toString()) // YYYY-MM-DD formatında
//       .set({
//     'morning': FieldValue.arrayUnion([1])
//   }, SetOptions(merge: true));

    final user = _userRepository.getLocalUser();

  //   await FirebaseFirestore.instance
  //     .collection(FirestoreCollection.users.value)
  //     .doc(user?.id??"")
  //     .collection(FirestoreCollection.cosmetics.value)
  //     .add({
  //   'name': "C vitamini",
  //   'brand': "korendy",
  //   'category': "Vitamin",
  //   'description': "Sadece sabahları tonik sonrası ilk kullanılır",

  // });
    if (user == null) return;
    emit(state.copyWith(user: user));
    await 300.milliseconds.delay<void>();
    emit(state.copyWith(status: HomeStatus.success, currentDay: DateTime.now()));
  }
//furkan@gmail.com
//betul@gmail.com
  Future<void> _homeDayChangedEvent(HomeDayChangedEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentDay: event.currentDay));
    isDayInWeek = isDayInWeekFunc(event.currentDay);
  }

  Future<void> _homeBackToTodayEvent(HomeBackToTodayEvent event, Emitter<HomeState> emit) async {
    final focusedDay = DateTime.now();
    emit(state.copyWith(focusedDay: focusedDay));
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

    return currentDay.isAfter(beginningOfWeek.subtract(const Duration(days: 1))) && currentDay.isBefore(endOfWeek.add(const Duration(seconds: 1)));
  }
}
