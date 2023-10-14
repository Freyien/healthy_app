part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailEvent extends SignUpEvent {
  const ChangeEmailEvent(this.email);

  final String email;
}

class ChangePasswordEvent extends SignUpEvent {
  const ChangePasswordEvent(this.password);

  final String password;
}

class ChangeShowPasswordEvent extends SignUpEvent {
  const ChangeShowPasswordEvent();
}

class SignUpwithEmailEvent extends SignUpEvent {
  const SignUpwithEmailEvent();
}

class SignUpwithGoogleEvent extends SignUpEvent {
  const SignUpwithGoogleEvent();
}

class SignUpwithAppleEvent extends SignUpEvent {
  const SignUpwithAppleEvent();
}
