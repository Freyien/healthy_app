import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/features/common/analytics/domain/repositories/analytics_repository.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsRepository _repository;

  AnalyticsBloc(this._repository) : super(AnalyticsState()) {
    on<SetDefaultParametersEvent>(_onSetDefaultParametersEvent);
    on<LogEvent>(_onLogEvent);
  }

  Future<void> _onSetDefaultParametersEvent(
    SetDefaultParametersEvent event,
    Emitter<AnalyticsState> emit,
  ) async {
    await _repository.setDefaultEventParameters();
  }

  Future<void> _onLogEvent(
    LogEvent event,
    Emitter<AnalyticsState> emit,
  ) async {
    await _repository.logEvent(event.eventName, event.parameters);
  }
}
