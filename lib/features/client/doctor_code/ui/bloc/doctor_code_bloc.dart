import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/features/client/doctor_code/domain/repositories/doctor_code_repository.dart';

part 'doctor_code_event.dart';
part 'doctor_code_state.dart';

class DoctorCodeBloc extends Bloc<DoctorCodeEvent, DoctorCodeState> {
  final DoctorCodeRepository _repository;

  DoctorCodeBloc(this._repository) : super(DoctorCodeState.initial()) {
    on<ChangeCodeEvent>(_onChangeCodeEvent);
    on<SaveCodeEvent>(_onSaveCodeEvent);
  }

  void _onChangeCodeEvent(
    ChangeCodeEvent event,
    Emitter<DoctorCodeState> emit,
  ) {
    emit(state.copyWith(code: event.code));
  }

  Future<void> _onSaveCodeEvent(
    SaveCodeEvent event,
    Emitter<DoctorCodeState> emit,
  ) async {
    emit(state.copyWith(savingStatus: SavingStatus.loading));

    final response = await _repository.saveDoctorCode(state.code);

    if (response.isFailed) {
      return emit(state.copyWith(
        savingStatus: SavingStatus.failure,
        failure: response.failure,
      ));
    }

    emit(state.copyWith(
      savingStatus: SavingStatus.success,
    ));
  }
}
