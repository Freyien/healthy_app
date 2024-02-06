import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/deleting_status.dart';
import 'package:healthy_app/features/client/delete_account/domain/repositories/delete_account_repository.dart';
import 'package:healthy_app/features/client/sign_in/domain/repositories/sign_in_repository.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteAccountRepository _repository;
  final SignInRepository _authRepository;

  DeleteAccountBloc(
    this._repository,
    this._authRepository,
  ) : super(DeleteAccountState()) {
    on<DeleteUserAccountEvent>(_onDeleteUserAccountEvent);
  }

  Future<void> _onDeleteUserAccountEvent(
    DeleteUserAccountEvent event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(state.copyWith(status: DeletingStatus.loading));

    final response = await _repository.deleteUserAccount();

    // Success
    if (response.isSuccess) {
      await _authRepository.signOut();
      return emit(
        state.copyWith(
          status: DeletingStatus.success,
        ),
      );
    }

    // Failures
    emit(
      state.copyWith(
        status: DeletingStatus.failure,
      ),
    );
  }
}
