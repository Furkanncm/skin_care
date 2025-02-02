part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeInitializedEvent extends HomeEvent {}

final class HomeDayChangedEvent extends HomeEvent {
  final DateTime currentDay;

  HomeDayChangedEvent({required this.currentDay});
}

final class HomeBackToTodayEvent extends HomeEvent{}

final class HomePageChangedOnCalendar extends HomeEvent{
    final DateTime focusedDay;

  HomePageChangedOnCalendar({required this.focusedDay});
}