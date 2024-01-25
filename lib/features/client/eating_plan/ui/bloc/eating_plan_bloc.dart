import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/eating_plan_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_block_entity.dart';
import 'package:healthy_app/features/client/eating_plan/domain/repositories/eating_plan_repository.dart';

part 'eating_plan_event.dart';
part 'eating_plan_state.dart';

class EatingPlanBloc extends Bloc<EatingPlanEvent, EatingPlanState> {
  final EatingPlanRepository _repository;

  EatingPlanBloc(this._repository) : super(EatingPlanState.initial()) {
    on<GetEatingPlanEvent>(_onGetEatingPlanEvent);
    on<CheckFoodEvent>(_onCheckFoodEvent);
  }

  Future<void> _onGetEatingPlanEvent(
    GetEatingPlanEvent event,
    Emitter<EatingPlanState> emit,
  ) async {
    emit(
      state.copyWith(
        fetchingStatus: FetchingStatus.loading,
        date: event.date,
      ),
    );

    final response = await _repository.getEatingPlan(event.date);

    if (response.isSuccess) {
      return emit(state.copyWith(
        fetchingStatus: FetchingStatus.success,
        eatingPlan: response.data!.checkFoodBlockList(),
      ));
    }

    emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
  }

  Future<void> _onCheckFoodEvent(
    CheckFoodEvent event,
    Emitter<EatingPlanState> emit,
  ) async {
    final newEatingPlan = state.eatingPlan.checkFoodBlock(
      event.foodBlock.id,
      event.checked,
    );

    emit(state.copyWith(eatingPlan: newEatingPlan));

    final response = await _repository.checkFoodOption(
      state.eatingPlan.foodChecked.id,
      event.foodBlock,
      event.checked,
    );

    if (response.isFailed) {
      emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
    }
  }
}
