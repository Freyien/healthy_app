import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/deleting_status.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_plan_entity.dart';
import 'package:healthy_app/features/client/water_plan/domain/repositories/water_plan_repository.dart';
import 'package:healthy_app/features/client/water_reminder/domain/repositories/water_reminder_repository.dart';

part 'water_plan_event.dart';
part 'water_plan_state.dart';

class WaterPlanBloc extends Bloc<WaterPlanEvent, WaterPlanState> {
  final WaterPlanRepository _repository;
  final WaterReminderRepository _waterReminderRepository;

  WaterPlanBloc(
    this._repository,
    this._waterReminderRepository,
  ) : super(WaterPlanState.initial()) {
    on<GetWaterPlanEvent>(_onGetWaterPlanEvent);
    on<AddWaterConsumptionEvent>(_onAddWaterConsumptionEvent);
    on<DeleteWaterConsumptionEvent>(_onDeleteWaterConsumptionEvent);
    on<AddWaterReminderEvent>(_onAddWaterReminderEvent);
  }

  Future<void> _onGetWaterPlanEvent(
    GetWaterPlanEvent event,
    Emitter<WaterPlanState> emit,
  ) async {
    emit(state.copyWith(
      fetchingStatus: FetchingStatus.loading,
      date: event.date,
    ));

    final response = await _repository.getWaterPlan(state.date);

    if (response.isFailed) {
      return emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
    }

    emit(state.copyWith(
      fetchingStatus: FetchingStatus.success,
      waterPlan: response.data,
    ));
  }

  Future<void> _onAddWaterConsumptionEvent(
    AddWaterConsumptionEvent event,
    Emitter<WaterPlanState> emit,
  ) async {
    emit(state.copyWith(savingStatus: SavingStatus.loading));

    final response = await _repository.addWaterConsumption(
      state.waterPlan.id,
      event.waterConsumption,
    );

    if (response.isFailed) {
      return emit(state.copyWith(savingStatus: SavingStatus.failure));
    }

    state.waterPlan.waterConsumptionList.insert(0, response.data!);

    emit(state.copyWith(savingStatus: SavingStatus.success));
  }

  Future<void> _onDeleteWaterConsumptionEvent(
    DeleteWaterConsumptionEvent event,
    Emitter<WaterPlanState> emit,
  ) async {
    emit(state.copyWith(deletingStatus: DeletingStatus.loading));

    final response = await _repository.deleteWaterConsumption(
      event.waterConsumption.id,
    );

    if (response.isFailed) {
      return emit(state.copyWith(deletingStatus: DeletingStatus.failure));
    }

    state.waterPlan.waterConsumptionList
        .removeWhere((e) => e.id == event.waterConsumption.id);

    final waterConsumptionList = state.waterPlan.waterConsumptionList
        .map((e) => e.copyWith(animate: false))
        .toList();

    emit(state.copyWith(
      deletingStatus: DeletingStatus.success,
      waterPlan: state.waterPlan.copyWith(
        waterConsumptionList: waterConsumptionList,
      ),
    ));
  }

  Future<void> _onAddWaterReminderEvent(
    AddWaterReminderEvent event,
    Emitter<WaterPlanState> emit,
  ) async {}
}
