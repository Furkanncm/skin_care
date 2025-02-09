part of 'home_bloc.dart';

enum HomeStatus { loading, success }

final class HomeState extends Equatable {
  HomeState({this.status = HomeStatus.loading, this.currentDay, this.focusedDay,this.user,this.cosmetics = const []});

  final HomeStatus status;
  final DateTime? currentDay;
  final DateTime? focusedDay;
  final MyUser? user;
  final List<Cosmetic> cosmetics ;

  @override
  List<Object?> get props => [status, currentDay, focusedDay,user ,cosmetics];

  HomeState copyWith({
    HomeStatus? status,
    DateTime? currentDay,
    DateTime? focusedDay,
    MyUser? user,
    List<Cosmetic>? cosmetics,
  }) {
    return HomeState(
      status: status ?? this.status,
      currentDay: currentDay ?? this.currentDay,
      focusedDay: focusedDay ?? this.focusedDay,
      user:user??this.user,
      cosmetics:cosmetics??this.cosmetics
    );
  }
}
