part of 'measure_bloc.dart';

sealed class MeasureEvent extends Equatable {
  const MeasureEvent();

  @override
  List<Object> get props => [];
}

class GetMeasureConsultationEvent extends MeasureEvent {}
