part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    required this.failure,
    required this.signUpForm,
    required this.status,
    required this.user,
  });

  final SignUpFailure failure;
  final SignUpFormEntity signUpForm;
  final SignUpStatus status;
  final UserEntity user;

  factory SignUpState.initial() => SignUpState(
        failure: SignUpFailure.none,
        signUpForm: SignUpFormEntity(),
        status: SignUpStatus.initial,
        user: UserEntity(),
      );

  SignUpState copyWith({
    SignUpFailure? failure,
    SignUpFormEntity? signUpForm,
    SignUpStatus? status,
    UserEntity? user,
  }) {
    return SignUpState(
      failure: failure ?? this.failure,
      signUpForm: signUpForm ?? this.signUpForm,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [failure, signUpForm, status, user];
}

enum SignUpStatus {
  initial,
  loading,
  failure,
  success,
}

enum SignUpFailure {
  none,
  unexpected,
  passwordTooWeakFailure,
  accountAlreadyExistsFailure,
  socialMediaCanceledFailure,
}
