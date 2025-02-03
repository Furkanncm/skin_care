part of 'home_bloc.dart';

enum HomeStatus { loading, success }

final class HomeState extends Equatable {
  HomeState({this.status = HomeStatus.loading, this.currentDay, this.focusedDay,this.user});

  final HomeStatus status;
  final DateTime? currentDay;
  final DateTime? focusedDay;
  final MyUser? user;
  @override
  List<Object?> get props => [status, currentDay, focusedDay,user];

  HomeState copyWith({
    HomeStatus? status,
    DateTime? currentDay,
    DateTime? focusedDay,
    MyUser? user,
  }) {
    return HomeState(
      status: status ?? this.status,
      currentDay: currentDay ?? this.currentDay,
      focusedDay: focusedDay ?? this.focusedDay,
      user:user??this.user
    );
  }
}
