import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'add_plan_event.dart';
part 'add_plan_state.dart';

@injectable
class AddPlanBloc extends Bloc<AddPlanEvent, AddPlanState> {
  AddPlanBloc() : super(AddPlanState()) {}
}
