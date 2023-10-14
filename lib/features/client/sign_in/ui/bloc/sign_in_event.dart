part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailEvent extends SignInEvent {
  const ChangeEmailEvent(this.email);

  final String email;
}

class ChangePasswordEvent extends SignInEvent {
  const ChangePasswordEvent(this.password);

  final String password;
}

class ChangeShowPasswordEvent extends SignInEvent {
  const ChangeShowPasswordEvent();
}

class SignInwithEmailEvent extends SignInEvent {
  const SignInwithEmailEvent();
}

class SignInwithGoogleEvent extends SignInEvent {
  const SignInwithGoogleEvent();
}

class SignInwithAppleEvent extends SignInEvent {
  const SignInwithAppleEvent();
}
