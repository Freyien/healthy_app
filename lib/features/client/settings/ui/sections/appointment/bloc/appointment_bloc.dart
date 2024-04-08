import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/features/client/settings/domain/entities/appointment_entity.dart';
import 'package:healthy_app/features/client/settings/domain/repositories/appointment_repository.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository _repository;

  AppointmentBloc(this._repository) : super(AppointmentState.initial()) {
    on<GetAppointmentEvent>(_onGetAppointmentEvent);
    on<ConfirmAppointmentEvent>(_onConfirmAppointmentEvent);
  }

  Future<void> _onGetAppointmentEvent(
    GetAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    await emit.forEach(
      _repository.getAppointment(),
      onData: (appointment) {
        return state.copyWith(
          appointment: appointment,
          fetchingStatus: FetchingStatus.success,
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(fetchingStatus: FetchingStatus.failure);
      },
    );
  }

  Future<void> _onConfirmAppointmentEvent(
    ConfirmAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(state.copyWith(savingStatus: SavingStatus.loading));

    final response = await _repository.confirmAppointment(state.appointment.id);

    if (response.isSuccess) {
      return emit(state.copyWith(savingStatus: SavingStatus.success));
    }

    emit(state.copyWith(savingStatus: SavingStatus.failure));
  }
}
