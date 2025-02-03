part of 'sign_up_bloc.dart';

enum SignUpStatus { loading, success }

final class SignUpState extends Equatable {
  SignUpState({this.status = SignUpStatus.loading, this.currentDay, this.focusedDay});

  final SignUpStatus status;
  final DateTime? currentDay;
  final DateTime? focusedDay;
  @override
  List<Object?> get props => [status, currentDay, focusedDay];

  SignUpState copyWith({
    SignUpStatus? status,
    DateTime? currentDay,
    DateTime? focusedDay,
  }) {
    return SignUpState(
      status: status ?? this.status,
      currentDay: currentDay ?? this.currentDay,
      focusedDay: focusedDay ?? this.focusedDay,
    );
  }
}
