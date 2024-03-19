import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/features/client/sign_in/domain/entities/entities.dart';
import 'package:healthy_app/features/common/forgot_password/domain/repositories/forgot_password_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordRepository _repository;

  ForgotPasswordBloc(this._repository) : super(ForgotPasswordState.initial()) {
    on<ChangeEmailEvent>(_onChangeEmail);
    on<SendPasswordResetEmailEvent>(_onSendPasswordResetEmailEvent);
  }

  void _onChangeEmail(
    ChangeEmailEvent event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(
      email: EmailEntity.dirty(event.value),
    ));
  }

  Future<void> _onSendPasswordResetEmailEvent(
    SendPasswordResetEmailEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(resetStatus: SavingStatus.loading));

    final email = state.email.value;
    final response = await _repository.sendPasswordResetEmail(email);

    if (response.isFailed) {
      return emit(state.copyWith(resetStatus: SavingStatus.failure));
    }

    emit(state.copyWith(resetStatus: SavingStatus.success));
  }
}
