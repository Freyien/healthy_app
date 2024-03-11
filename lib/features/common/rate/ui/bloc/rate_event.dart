part of 'rate_bloc.dart';

sealed class RateEvent extends Equatable {
  const RateEvent();

  @override
  List<Object> get props => [];
}

class RequestReviewEvent extends RateEvent {}
