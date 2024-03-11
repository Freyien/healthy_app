import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/features/common/rate/domain/repositories/rate_repository.dart';

part 'rate_event.dart';
part 'rate_state.dart';

class RateBloc extends Bloc<RateEvent, RateState> {
  final RateRepository _repository;

  RateBloc(this._repository) : super(RateState()) {
    on<RequestReviewEvent>(_onRequestReviewEvent);
  }

  Future<void> _onRequestReviewEvent(
    RequestReviewEvent event,
    Emitter<RateState> emit,
  ) async {
    emit(state.copyWith(status: SavingStatus.loading));

    await _repository.requestReview();

    emit(state.copyWith(status: SavingStatus.success));
  }
}
