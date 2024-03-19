import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/features/common/forgot_password/domain/repositories/forgot_password_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ForgotPasswordRepository _repository;

  ResetPasswordBloc(this._repository) : super(ResetPasswordState()) {
    on<SendPasswordResetEmailEvent>(_onSendPasswordResetEmailEvent);
    on<SetEmailEvent>(_onSetEmailEvent);
    on<EnableButtonEvent>(_onEnableButtonEvent);
  }

  Future<void> _onSetEmailEvent(
    SetEmailEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(
      state.copyWith(email: event.email),
    );
  }

  Future<void> _onSendPasswordResetEmailEvent(
    SendPasswordResetEmailEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(savingStatus: SavingStatus.loading));

    final response = await _repository.sendPasswordResetEmail(state.email);

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

  Future<void> _onEnableButtonEvent(
    EnableButtonEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(enabledButton: true));
  }
}
