part of 'rate_bloc.dart';

class RateState extends Equatable {
  const RateState({
    this.status = SavingStatus.initial,
  });

  final SavingStatus status;

  RateState copyWith({
    SavingStatus? status,
  }) {
    return RateState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
