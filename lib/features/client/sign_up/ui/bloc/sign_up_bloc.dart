import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/entities/user_entity.dart';
import 'package:healthy_app/features/client/sign_up/domain/entities/entities.dart';
import 'package:healthy_app/features/client/sign_up/domain/failures/auth_failure.dart';
import 'package:healthy_app/features/client/sign_up/domain/repositories/sign_up_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._signUpRepository) : super(SignUpState.initial()) {
    on<ChangeEmailEvent>(_onChangeEmail);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ChangeShowPasswordEvent>(_onChangeShowPassword);
    on<SignUpwithEmailEvent>(_onSignUpwithEmailEvent);
    on<SignUpwithGoogleEvent>(_onSignUpwithGoogleEvent);
    on<SignUpwithAppleEvent>(_onSignUpwithAppleEvent);
  }

  final SignUpRepository _signUpRepository;

  void _onChangeEmail(ChangeEmailEvent event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        status: SignUpStatus.initial,
        signUpForm: state.signUpForm.copyWith(
          email: EmailEntity.dirty(event.email),
        ),
      ),
    );
  }

  void _onChangePassword(ChangePasswordEvent event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        status: SignUpStatus.initial,
        signUpForm: state.signUpForm.copyWith(
          password: PasswordEntity.dirty(event.password),
        ),
      ),
    );
  }

  void _onChangeShowPassword(
    ChangeShowPasswordEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        status: SignUpStatus.initial,
        signUpForm: state.signUpForm.copyWith(
          showPassword: !state.signUpForm.showPassword,
        ),
      ),
    );
  }

  Future<void> _onSignUpwithEmailEvent(
    SignUpwithEmailEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );

    final email = state.signUpForm.email.value;
    final password = state.signUpForm.password.value;

    final response = await _signUpRepository.signUpWithEmail(
      email,
      password,
    );

    // Success
    if (response.isSuccess) {
      return emit(
        state.copyWith(
          status: SignUpStatus.success,
          user: response.data,
        ),
      );
    }

    // Failures
    var failure = SignUpFailure.unexpected;
    if (response.failure is PasswordTooWeakFailure) {
      failure = SignUpFailure.passwordTooWeakFailure;
    } else if (response.failure is AccountAlreadyExistsFailure) {
      failure = SignUpFailure.accountAlreadyExistsFailure;
    }

    emit(
      state.copyWith(
        status: SignUpStatus.failure,
        failure: failure,
      ),
    );
  }

  Future<void> _onSignUpwithGoogleEvent(
    SignUpwithGoogleEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );

    final response = await _signUpRepository.signUpWithGoogle();

    // Success
    if (response.isSuccess) {
      return emit(
        state.copyWith(
          status: SignUpStatus.success,
          user: response.data,
        ),
      );
    }

    // Failures
    var failure = SignUpFailure.unexpected;
    if (response.failure is SocialMediaCanceledFailure) {
      failure = SignUpFailure.socialMediaCanceledFailure;
    }

    emit(
      state.copyWith(
        status: SignUpStatus.failure,
        failure: failure,
      ),
    );
  }

  Future<void> _onSignUpwithAppleEvent(
    SignUpwithAppleEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );

    final response = await _signUpRepository.signUpWithApple();

    // Success
    if (response.isSuccess) {
      return emit(
        state.copyWith(
          status: SignUpStatus.success,
          user: response.data,
        ),
      );
    }

    // Failures
    var failure = SignUpFailure.unexpected;
    if (response.failure is SocialMediaCanceledFailure) {
      failure = SignUpFailure.socialMediaCanceledFailure;
    }

    emit(
      state.copyWith(
        status: SignUpStatus.failure,
        failure: failure,
      ),
    );
  }
}
