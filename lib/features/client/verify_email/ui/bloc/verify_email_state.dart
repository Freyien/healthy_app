part of 'verify_email_bloc.dart';

class VerifyEmailState extends Equatable {
  const VerifyEmailState({
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

  VerifyEmailState copyWith({
    String? email,
    SavingStatus? savingStatus,
    FetchingStatus? fetchingStatus,
    bool? emailVerified,
    bool? enabledButton,
  }) {
    return VerifyEmailState(
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
