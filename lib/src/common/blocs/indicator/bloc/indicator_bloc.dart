import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/domain/indicator/indicator_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'indicator_event.dart';
part 'indicator_state.dart';

@lazySingleton
class IndicatorBloc extends Bloc<IndicatorEvent, IndicatorState> {
  IndicatorBloc(this._indicatorRepository) : super(const IndicatorInitial()) {
    on<_IndicatorShowedEvent>(_showIndicator);
    on<_IndicatorHiddenEvent>(_hideIndicator);

    _indicatorRepository.status.listen((state) {
      if (state is IndicatorShow) {
        add(_IndicatorShowedEvent(state.indicatorKey));
      } else if (state is IndicatorHide) {
        add(_IndicatorHiddenEvent(state.indicatorKey));
      }
    });
  }

  final IndicatorRepository _indicatorRepository;

  Future<void> _showIndicator(_IndicatorShowedEvent event, Emitter<IndicatorState> emit) async {
    emit(IndicatorShow(indicatorKey: event.indicatorKey));
  }

  Future<void> _hideIndicator(_IndicatorHiddenEvent event, Emitter<IndicatorState> emit) async {
    emit(IndicatorHide(indicatorKey: event.indicatorKey));
  }
}
