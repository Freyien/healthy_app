part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    required this.email,
    required this.resetStatus,
  });

  final EmailEntity email;
  final SavingStatus resetStatus;

  factory ForgotPasswordState.initial() => ForgotPasswordState(
        email: EmailEntity.pure(),
        resetStatus: SavingStatus.initial,
      );

  ForgotPasswordState copyWith({
    EmailEntity? email,
    SavingStatus? resetStatus,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      resetStatus: resetStatus ?? this.resetStatus,
    );
  }

  @override
  List<Object> get props => [email, resetStatus];
}
