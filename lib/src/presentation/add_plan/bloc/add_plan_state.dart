part of 'add_plan_bloc.dart';

enum AddPlanStatus {
  loading,
  loaded,
  error,
  existingPlan,
}

final class AddPlanState extends Equatable {
  AddPlanState({
    this.status = AddPlanStatus.loading,
    this.selectedDate,
    this.cosmetics,
    this.isMorning = false,
    this.isEvening = false,
    this.addedCosmetics,
    this.user,
  });

  final AddPlanStatus status;
  final DateTime? selectedDate;
  final List<Cosmetic>? cosmetics;
  final bool isMorning;
  final bool isEvening;
  final List<Cosmetic>? addedCosmetics;
  final MyUser? user;

  @override
  List<Object?> get props => [status, selectedDate, cosmetics, isMorning, isEvening, addedCosmetics, user];

  AddPlanState copyWith({
    AddPlanStatus? status,
    DateTime? selectedDate,
    List<Cosmetic>? cosmetics,
    bool? isMorning,
    bool? isEvening,
    List<Cosmetic>? addedCosmetics,
    MyUser? user,
  }) {
    return AddPlanState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      cosmetics: cosmetics ?? this.cosmetics,
      isMorning: isMorning ?? this.isMorning,
      isEvening: isEvening ?? this.isEvening,
      addedCosmetics: addedCosmetics ?? this.addedCosmetics,
      user: user ?? this.user,
    );
  }
}
