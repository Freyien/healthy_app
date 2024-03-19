part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class SetEmailEvent extends ResetPasswordEvent {
  final String email;

  SetEmailEvent(this.email);
}

class SendPasswordResetEmailEvent extends ResetPasswordEvent {}

class EnableButtonEvent extends ResetPasswordEvent {}
