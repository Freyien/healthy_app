part of 'verify_email_bloc.dart';

sealed class VerifyEmailEvent extends Equatable {
  const VerifyEmailEvent();

  @override
  List<Object> get props => [];
}

class GetEmailEvent extends VerifyEmailEvent {}

class ResendEmailVerificationEvent extends VerifyEmailEvent {}

class CheckEmailVerifiedEvent extends VerifyEmailEvent {}

class EnableButtonEvent extends VerifyEmailEvent {}
