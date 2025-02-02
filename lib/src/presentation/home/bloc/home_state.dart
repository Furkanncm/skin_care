part of 'home_bloc.dart';

enum HomeStatus { loading, success }

final class HomeState extends Equatable {
  HomeState({this.status = HomeStatus.loading, this.currentDay, this.focusedDay});

  final HomeStatus status;
  final DateTime? currentDay;
  final DateTime? focusedDay;
  @override
  List<Object?> get props => [status, currentDay, focusedDay];

  HomeState copyWith({
    HomeStatus? status,
    DateTime? currentDay,
    DateTime? focusedDay,
  }) {
    return HomeState(
      status: status ?? this.status,
      currentDay: currentDay ?? this.currentDay,
      focusedDay: focusedDay ?? this.focusedDay,
    );
  }
}
