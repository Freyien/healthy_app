import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/features/client/verify_email/domain/repositories/verify_email_repository.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final VerifyEmailRepository _repository;

  VerifyEmailBloc(this._repository) : super(VerifyEmailState()) {
    on<ResendEmailVerificationEvent>(_onResendEmailVerificationEvent);
    on<GetEmailEvent>(_onGetEmailEvent);
    on<CheckEmailVerifiedEvent>(_onCheckEmailVerifiedEvent);
    on<EnableButtonEvent>(_onEnableButtonEvent);
  }

  Future<void> _onGetEmailEvent(
    GetEmailEvent event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    final response = await _repository.getEmailEvent();

    if (response.isFailed) {
      return emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
    }

    emit(
      state.copyWith(
        email: response.data!,
        fetchingStatus: FetchingStatus.success,
      ),
    );
  }

  Future<void> _onResendEmailVerificationEvent(
    ResendEmailVerificationEvent event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(state.copyWith(savingStatus: SavingStatus.loading));

    final response = await _repository.sendEmailVerification();

    if (response.isFailed) {
      return emit(state.copyWith(
        savingStatus: SavingStatus.failure,
        enabledButton: true,
      ));
    }

    emit(state.copyWith(
      savingStatus: SavingStatus.success,
      enabledButton: false,
    ));
  }

  Future<void> _onCheckEmailVerifiedEvent(
    CheckEmailVerifiedEvent event,
    Emitter<VerifyEmailState> emit,
  ) async {
    final response = await _repository.checkEmailVerified();

    if (response.isFailed) {
      return emit(state.copyWith(emailVerified: false));
    }

    return emit(state.copyWith(emailVerified: response.data!));
  }

  Future<void> _onEnableButtonEvent(
    EnableButtonEvent event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(state.copyWith(enabledButton: true));
  }
}
