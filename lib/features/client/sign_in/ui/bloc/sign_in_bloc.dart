import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/features/client/sign_in/domain/entities/entities.dart';
import 'package:healthy_app/features/client/sign_in/domain/failures/auth_failure.dart';
import 'package:healthy_app/features/client/sign_in/domain/repositories/sign_in_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._signInRepository) : super(SignInState.initial()) {
    on<ChangeEmailEvent>(_onChangeEmail);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ChangeShowPasswordEvent>(_onChangeShowPassword);
    on<SignInwithEmailEvent>(_onSignInwithEmailEvent);
    on<SignInwithGoogleEvent>(_onSignInwithGoogleEvent);
    on<SignInwithAppleEvent>(_onSignInwithAppleEvent);
  }

  final SignInRepository _signInRepository;

  void _onChangeEmail(ChangeEmailEvent event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        status: SignInStatus.initial,
        signInForm: state.signInForm.copyWith(
          email: EmailEntity.dirty(event.email),
        ),
      ),
    );
  }

  void _onChangePassword(ChangePasswordEvent event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        status: SignInStatus.initial,
        signInForm: state.signInForm.copyWith(
          password: PasswordEntity.dirty(event.password),
        ),
      ),
    );
  }

  void _onChangeShowPassword(
    ChangeShowPasswordEvent event,
    Emitter<SignInState> emit,
  ) {
    emit(
      state.copyWith(
        status: SignInStatus.initial,
        signInForm: state.signInForm.copyWith(
          showPassword: !state.signInForm.showPassword,
        ),
      ),
    );
  }

  Future<void> _onSignInwithEmailEvent(
    SignInwithEmailEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(status: SignInStatus.loading),
    );

    final email = state.signInForm.email.value;
    final password = state.signInForm.password.value;

    final response = await _signInRepository.loginWithEmail(
      email,
      password,
    );

    // Success
    if (response.isSuccess) {
      return emit(
        state.copyWith(
          status: SignInStatus.success,
        ),
      );
    }

    // Failures
    var failure = SignInFailure.unexpected;
    if (response.failure is InvalidCredentialsFailure) {
      failure = SignInFailure.invalidCredentialsFailure;
    } else if (response.failure is UserNotFoundFailure) {
      failure = SignInFailure.userNotFound;
    }

    emit(
      state.copyWith(
        status: SignInStatus.failure,
        failure: failure,
      ),
    );
  }

  Future<void> _onSignInwithGoogleEvent(
    SignInwithGoogleEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(status: SignInStatus.loading),
    );

    final response = await _signInRepository.signInWithGoogle();

    // Success
    if (response.isSuccess) {
      return emit(
        state.copyWith(
          status: SignInStatus.success,
        ),
      );
    }

    // Failures
    var failure = SignInFailure.unexpected;
    if (response.failure is SocialMediaCanceledFailure) {
      failure = SignInFailure.socialMediaCanceledFailure;
    }

    emit(
      state.copyWith(
        status: SignInStatus.failure,
        failure: failure,
      ),
    );
  }

  Future<void> _onSignInwithAppleEvent(
    SignInwithAppleEvent event,
    Emitter<SignInState> emit,
  ) async {
    // emit(
    //   state.copyWith(status: SignInStatus.loading),
    // );

    final response = await _signInRepository.signInWithApple();

    // Success
    if (response.isSuccess) {
      return emit(
        state.copyWith(
          status: SignInStatus.success,
        ),
      );
    }

    // Failures
    var failure = SignInFailure.unexpected;
    if (response.failure is SocialMediaCanceledFailure) {
      failure = SignInFailure.socialMediaCanceledFailure;
    }

    emit(
      state.copyWith(
        status: SignInStatus.failure,
        failure: failure,
      ),
    );
  }
}
