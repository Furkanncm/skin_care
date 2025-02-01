import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/domain/app_version_state/app_version_state_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';


part 'version_control_state.dart';

@injectable
final class VersionControlCubit extends Cubit<VersionControlState> {
  VersionControlCubit(this._appVersionStateRepository) : super(const VersionControlNoOptionalUpdateAvailable()) {
    _appVersionStateRepository.status.listen(emit);
  }

  final AppVersionStateRepository _appVersionStateRepository;

  @override
  Future<void> close() {
    _appVersionStateRepository.dispose();
    return super.close();
  }
}
