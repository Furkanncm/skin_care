import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:bloc_clean_architecture/src/domain/localization/localization_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'localization_event.dart';
part 'localization_state.dart';

@singleton
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc(this._localizationRepository) : super(const LocalizationState()) {
    on<_LocalizationChangedEvent>(_changeLocale);

    _localizationRepository.status.listen((localizationData) {
      add(_LocalizationChangedEvent(localizationData));
    });
  }

  final LocalizationRepository _localizationRepository;

  Future<void> _changeLocale(_LocalizationChangedEvent event, Emitter<LocalizationState> emit) async {
    emit(state.copyWith(culture: event.culture));
  }
}
