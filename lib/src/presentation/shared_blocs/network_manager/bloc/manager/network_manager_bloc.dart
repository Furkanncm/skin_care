import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/base_response.dart';
import 'package:bloc_clean_architecture/src/domain/network_manager/network_manager_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'network_manager_event.dart';
part 'network_manager_state.dart';

@lazySingleton
class NetworkManagerBloc extends Bloc<NetworkManagerEvent, NetworkManagerState> {
  NetworkManagerBloc(this._networkManagerRepository) : super(NetworkManagerInitial()) {
    on<_NetworkManagerSuccessArrivedEvent>(_networkManagerSuccessArrived);
    on<_NetworkManagerErrorArrivedEvent>(_networkManagerErrorArrived);

    _networkManagerRepository.status.listen((state) {
      if (state is NetworkManagerSuccess) {
        add(_NetworkManagerSuccessArrivedEvent(state.baseResponse!));
      } else if (state is NetworkManagerError) {
        add(_NetworkManagerErrorArrivedEvent(state.baseResponse!));
      }
    });
  }

  final NetworkManagerRepository _networkManagerRepository;

  Future<void> _networkManagerSuccessArrived(_NetworkManagerSuccessArrivedEvent event, Emitter<NetworkManagerState> emit) async {
    emit(NetworkManagerSuccess(baseResponse: event.baseResponse));
  }

  Future<void> _networkManagerErrorArrived(_NetworkManagerErrorArrivedEvent event, Emitter<NetworkManagerState> emit) async {
    emit(NetworkManagerError(baseResponse: event.baseResponse));
  }
}
