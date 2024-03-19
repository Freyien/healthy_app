part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailEvent extends ForgotPasswordEvent {
  final String value;

  ChangeEmailEvent(this.value);
}

class SendPasswordResetEmailEvent extends ForgotPasswordEvent {
  SendPasswordResetEmailEvent();
}
