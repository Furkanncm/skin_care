part of 'add_plan_bloc.dart';

sealed class AddPlanEvent extends Equatable {
  const AddPlanEvent();

  @override
  List<Object> get props => [];
}

final class AddPlanInitialEvent extends AddPlanEvent {}

final class AddPlanSelectDateEvent extends AddPlanEvent {
  final DateTime date;
  const AddPlanSelectDateEvent({required this.date});
}

final class AddPlanIsMorningEvent extends AddPlanEvent {
  final bool isMorning;
  const AddPlanIsMorningEvent({required this.isMorning});
}

final class AddPlanIsEveningEvent extends AddPlanEvent {
  final bool isEvening;
  const AddPlanIsEveningEvent({required this.isEvening});
}

final class AddPlanAddCosmeticEvent extends AddPlanEvent {
  final Cosmetic cosmetic;
  const AddPlanAddCosmeticEvent({required this.cosmetic});
}

final class AddPlanSubmitPlansEvent extends AddPlanEvent {
  final BuildContext context;

  AddPlanSubmitPlansEvent({required this.context});
}
