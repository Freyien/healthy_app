import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_chart_data_entity.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_chart_element_entity.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_consultation_entity.dart';
import 'package:healthy_app/features/client/measures_chart/domain/repositories/measure_repository.dart';

part 'measure_event.dart';
part 'measure_state.dart';

class MeasureBloc extends Bloc<MeasureEvent, MeasureState> {
  final MeasureRepository _repository;

  MeasureBloc(this._repository) : super(MeasureState.initial()) {
    on<GetMeasureConsultationEvent>(_onGetMeasureConsultationEvent);
  }

  Future<void> _onGetMeasureConsultationEvent(
    GetMeasureConsultationEvent event,
    Emitter<MeasureState> emit,
  ) async {
    emit(state.copyWith(fetchingStatus: FetchingStatus.loading));

    final response = await _repository.getMeasureConsultation();

    if (response.isFailed) {
      return emit(state.copyWith(fetchingStatus: FetchingStatus.failure));
    }

    emit(state.copyWith(
      fetchingStatus: FetchingStatus.success,
      measureConsultationList: response.data,
    ));
  }
}
