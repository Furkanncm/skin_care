part of 'home_bloc.dart';

enum HomeStatus { loading, success }

final class HomeState extends Equatable {
  HomeState({
    this.status = HomeStatus.loading,
    this.currentDay,
    this.focusedDay,
    this.user,
    this.cosmetics = const [],
    this.plan,
    this.todaysPlan,
  });

  final HomeStatus status;
  final DateTime? currentDay;
  final DateTime? focusedDay;
  final MyUser? user;
  final List<Cosmetic> cosmetics;
  final List<Plan>? plan;
  final Plan? todaysPlan;
  @override
  List<Object?> get props => [status, currentDay, focusedDay, user, cosmetics, plan,todaysPlan];

  HomeState copyWith({
    HomeStatus? status,
    DateTime? currentDay,
    DateTime? focusedDay,
    MyUser? user,
    List<Cosmetic>? cosmetics,
    List<Plan>? plan,
    Plan? todaysPlan,
  }) {
    return HomeState(
      status: status ?? this.status,
      currentDay: currentDay ?? this.currentDay,
      focusedDay: focusedDay ?? this.focusedDay,
      user: user ?? this.user,
      cosmetics: cosmetics ?? this.cosmetics,
      plan: plan ?? this.plan,
      todaysPlan: todaysPlan ?? this.todaysPlan,
    );
  }
}
