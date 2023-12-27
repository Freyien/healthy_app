part of 'doctor_code_bloc.dart';

sealed class DoctorCodeEvent extends Equatable {
  const DoctorCodeEvent();

  @override
  List<Object> get props => [];
}

class ChangeCodeEvent extends DoctorCodeEvent {
  final String code;

  ChangeCodeEvent(this.code);
}

class SaveCodeEvent extends DoctorCodeEvent {}
