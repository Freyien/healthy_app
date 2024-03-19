part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.email = '',
    this.savingStatus = SavingStatus.initial,
    this.fetchingStatus = FetchingStatus.initial,
    this.emailVerified = false,
    this.enabledButton = false,
  });

  final String email;
  final SavingStatus savingStatus;
  final FetchingStatus fetchingStatus;
  final bool emailVerified;
  final bool enabledButton;

  ResetPasswordState copyWith({
    String? email,
    SavingStatus? savingStatus,
    FetchingStatus? fetchingStatus,
    bool? emailVerified,
    bool? enabledButton,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      savingStatus: savingStatus ?? this.savingStatus,
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      emailVerified: emailVerified ?? this.emailVerified,
      enabledButton: enabledButton ?? this.enabledButton,
    );
  }

  @override
  List<Object> get props {
    return [
      email,
      savingStatus,
      fetchingStatus,
      emailVerified,
      enabledButton,
    ];
  }
}
