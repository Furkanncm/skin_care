import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/extensions/future_extension.dart';
import 'package:bloc_clean_architecture/src/common/network_manager/future_base_response_extension.dart';
import 'package:bloc_clean_architecture/src/data/model/my_user/my_user.dart';
import 'package:bloc_clean_architecture/src/domain/auth/auth_repository.dart';
import 'package:bloc_clean_architecture/src/domain/user/user_repository.dart';
import 'package:bloc_clean_architecture/src/presentation/shared_blocs/auth/bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/color_scheme/dto/color_scheme_dto.dart';
import '../../../data/model/localization/response/culture.dart';
import '../../../domain/localization/localization_repository.dart';
import '../../../domain/theme/theme_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._authRepository,
    this._userRepository,
    this._themeRepository,
    this._localizationRepository,
  ) : super(ProfileState()) {
    on<ProfileEventInitialize>(_profileEventInitialize);
    on<ProfileLogOutEvent>(_profileLogOutEvent);
    on<ProfileChangePhotoEvent>(_profileChangePhotoEvent);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final ThemeRepository _themeRepository;
  final LocalizationRepository _localizationRepository;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _profileEventInitialize(ProfileEventInitialize event, Emitter<ProfileState> emit) async {
    final user = await _userRepository.getLocalUser();
    final colorSchemes = await _themeRepository.getColorSchemes();
    final result = await _localizationRepository.getCultures().intercept();
    final cultures = result.data ?? <Culture>[];
    final selectedCulture = _localizationRepository.getSelectedCulture();
    if (selectedCulture.isNull) throw Exception('Selected culture is null');
    emit(state.copyWith(status: ProfileStatus.loaded, colorSchemes: colorSchemes, cultures: cultures, selectedCulture: selectedCulture, user: user));
  }

  Future<void> _profileLogOutEvent(ProfileLogOutEvent event, Emitter<ProfileState> emit) async {
    final logoutResponse = await _authRepository.logout().intercept().withIndicator();
    if (!(logoutResponse.succeeded ?? false)) return;
    _authRepository.changeAuthState(authState: const AuthState.unAuthenticated());
    unawaited(_userRepository.deleteLocalUser());
    unawaited(_authRepository.deleteUserCredentials());
  }

  Future<void> _profileChangePhotoEvent(ProfileChangePhotoEvent event, Emitter<ProfileState> emit) async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image.isNull) return;
    final File file = File(image!.path);
    final user = state.user!.copyWith(imagePath: file.path);
    emit(state.copyWith(user: user));
  }
}
