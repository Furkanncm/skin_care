part of 'profile_bloc.dart';

enum ProfileStatus { loading, loaded }

class ProfileState extends Equatable {
  final List<MyColorSchemeDto> colorSchemes;
  final List<Culture>? cultures;
  final Culture? selectedCulture;
  final ProfileStatus status;
  final MyUser? user;

  ProfileState({
    this.colorSchemes = const [],
    this.cultures,
    this.selectedCulture,
    this.status = ProfileStatus.loading,
    this.user,
  });

  @override
  List<Object?> get props => [colorSchemes, cultures, selectedCulture, status,user];

  ProfileState copyWith({
    List<MyColorSchemeDto>? colorSchemes,
    List<Culture>? cultures,
    Culture? selectedCulture,
    ProfileStatus? status,
    MyUser? user,
  }) {
    return ProfileState(
      colorSchemes: colorSchemes ?? this.colorSchemes,
      cultures: cultures ?? this.cultures,
      selectedCulture: selectedCulture ?? this.selectedCulture,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
