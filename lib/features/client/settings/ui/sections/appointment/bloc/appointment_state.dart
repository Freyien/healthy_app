part of 'appointment_bloc.dart';

class AppointmentState extends Equatable {
  const AppointmentState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.appointment,
  });

  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final AppointmentEntity appointment;

  factory AppointmentState.initial() => AppointmentState(
        fetchingStatus: FetchingStatus.initial,
        savingStatus: SavingStatus.initial,
        appointment: AppointmentEntity.initial(),
      );

  AppointmentState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    AppointmentEntity? appointment,
  }) {
    return AppointmentState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      appointment: appointment ?? this.appointment,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, savingStatus, appointment];
}
