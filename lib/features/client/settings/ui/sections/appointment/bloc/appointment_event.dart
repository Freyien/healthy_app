part of 'appointment_bloc.dart';

sealed class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class GetAppointmentEvent extends AppointmentEvent {}

class ConfirmAppointmentEvent extends AppointmentEvent {}
