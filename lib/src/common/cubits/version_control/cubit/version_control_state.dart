part of 'version_control_cubit.dart';

sealed class VersionControlState extends Equatable {
  const VersionControlState();
}

final class VersionControlNoOptionalUpdateAvailable extends VersionControlState {
  const VersionControlNoOptionalUpdateAvailable();
  @override
  List<Object> get props => [];
}

final class VersionControlOptionalUpdateAvailable extends VersionControlState {
  const VersionControlOptionalUpdateAvailable(this.version);
  final String version;

  @override
  List<Object> get props => [version];
}
