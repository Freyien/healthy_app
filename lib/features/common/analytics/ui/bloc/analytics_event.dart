part of 'analytics_bloc.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object> get props => [];
}

class SetDefaultParametersEvent extends AnalyticsEvent {
  const SetDefaultParametersEvent();
}

class LogEvent extends AnalyticsEvent {
  final String eventName;
  final Map<String, dynamic> parameters;

  LogEvent(
    this.eventName, {
    this.parameters = const {},
  });
}
