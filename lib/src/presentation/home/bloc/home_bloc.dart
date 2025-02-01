import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<HomeInitializedEvent>(_initialize);
  }

  Future<void> _initialize(HomeEvent event, Emitter<HomeState> emit) async {
    await 300.milliseconds.delay<void>();
    emit(HomeSuccess());
  }
}
