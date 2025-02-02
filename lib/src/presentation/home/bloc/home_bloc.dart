import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeInitializedEvent>(_initialize);
    on<HomeDayChangedEvent>(_homeDayChangedEvent);
    on<HomeBackToTodayEvent>(_homeBackToTodayEvent);
    on<HomePageChangedOnCalendar>(_homePageChangedOnCalendar);
  }

  bool isDayInWeek = true;
  Future<void> _initialize(HomeEvent event, Emitter<HomeState> emit) async {
    await 300.milliseconds.delay<void>();
    emit(state.copyWith(status: HomeStatus.success, currentDay: DateTime.now()));
  }

  Future<void> _homeDayChangedEvent(HomeDayChangedEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentDay: event.currentDay));
    isDayInWeek = isDayInWeekFunc(event.currentDay);
  }

  bool isDayInWeekFunc(DateTime currentDay) {
    final now = DateTime.now();
    final beginningOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Haftanın başlangıcı (Pazartesi)
    final endOfWeek = beginningOfWeek.add(Duration(days: 6)); // Haftanın sonu (Pazar)
    return currentDay.isAfter(beginningOfWeek.subtract(const Duration(seconds: 1))) && currentDay.isBefore(endOfWeek.add(const Duration(seconds: 1)));
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
}
