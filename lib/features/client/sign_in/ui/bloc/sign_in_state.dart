part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    required this.failure,
    required this.signInForm,
    required this.status,
  });

  final SignInFailure failure;
  final SignInFormEntity signInForm;
  final SignInStatus status;

  factory SignInState.initial() => SignInState(
        failure: SignInFailure.none,
        signInForm: SignInFormEntity(),
        status: SignInStatus.initial,
      );

  SignInState copyWith({
    SignInFailure? failure,
    SignInFormEntity? signInForm,
    SignInStatus? status,
  }) {
    return SignInState(
      failure: failure ?? this.failure,
      signInForm: signInForm ?? this.signInForm,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [failure, signInForm, status];
}

enum SignInStatus {
  initial,
  loading,
  failure,
  success,
}

enum SignInFailure {
  none,
  unexpected,
  invalidCredentialsFailure,
  userNotFound,
  socialMediaCanceledFailure,
}
