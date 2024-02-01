import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/features/client/water_reminder/domain/entities/water_reminder_entity.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';

part 'water_reminder_event.dart';
part 'water_reminder_state.dart';

class WaterReminderBloc extends Bloc<WaterReminderEvent, WaterReminderState> {
  final WaterReminderRepository _repository;

  WaterReminderBloc(this._repository) : super(WaterReminderState.initial()) {
    on<GetWaterReminderEvent>(_onGetWaterReminderEvent);
    on<ChangeEnableEvent>(_onChangeEnableEvent);
    on<ChangeIntervalEvent>(_onChangeIntervalEvent);
    on<ChangeStartTimeEvent>(_onChangeStartTimeEvent);
    on<ChangeEndTimeEvent>(_onChangeEndTimeEvent);
    on<SaveEvent>(_onSaveEvent);
  }

  Future<void> _onGetWaterReminderEvent(
    GetWaterReminderEvent event,
    Emitter<WaterReminderState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    final response = await _repository.getWaterReminder();

    if (response.isFailed) {
      return emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
    }

    emit(state.copyWith(
      fetchingStatus: FetchingStatus.success,
      waterReminder: response.data,
    ));
  }

  void _onChangeEnableEvent(
    ChangeEnableEvent event,
    Emitter<WaterReminderState> emit,
  ) {
    emit(
      state.copyWith(
        waterReminder: state.waterReminder.copyWith(
          enable: event.value,
        ),
      ),
    );
  }

  void _onChangeIntervalEvent(
    ChangeIntervalEvent event,
    Emitter<WaterReminderState> emit,
  ) {
    emit(
      state.copyWith(
        waterReminder: state.waterReminder.copyWith(
          minuteInterval: event.value,
        ),
      ),
    );
  }

  void _onChangeStartTimeEvent(
    ChangeStartTimeEvent event,
    Emitter<WaterReminderState> emit,
  ) {
    emit(
      state.copyWith(
        waterReminder: state.waterReminder.copyWith(
          start: event.value,
        ),
      ),
    );
  }

  void _onChangeEndTimeEvent(
    ChangeEndTimeEvent event,
    Emitter<WaterReminderState> emit,
  ) {
    emit(
      state.copyWith(
        waterReminder: state.waterReminder.copyWith(
          end: event.value,
        ),
      ),
    );
  }

  Future<void> _onSaveEvent(
    SaveEvent event,
    Emitter<WaterReminderState> emit,
  ) async {
    emit(state.copyWith(savingStatus: SavingStatus.loading));

    final response = await _repository.saveWaterReminder(state.waterReminder);

    if (response.isFailed) {
      return emit(state.copyWith(savingStatus: SavingStatus.failure));
    }

    return emit(state.copyWith(savingStatus: SavingStatus.success));

    // Edit reminder
    // if (state.waterReminder.enable) {
    //   final addReminderResponse = await _repository.addLocalWaterReminder(
    //     state.waterReminder,
    //     replaceIfExists: true,
    //   );

    //   if (addReminderResponse.isFailed) {
    //     return emit(state.copyWith(savingStatus: SavingStatus.failure));
    //   }

    //   return emit(state.copyWith(savingStatus: SavingStatus.success));
    // }

    // Cancel reminders
    // final cancelResponse = await _repository.cancelWaterReminders();

    // if (cancelResponse.isFailed) {
    //   return emit(state.copyWith(savingStatus: SavingStatus.failure));
    // }

    // return emit(state.copyWith(savingStatus: SavingStatus.success));
  }
}
