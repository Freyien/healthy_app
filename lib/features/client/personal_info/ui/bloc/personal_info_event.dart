part of 'personal_info_bloc.dart';

sealed class PersonalInfoEvent extends Equatable {
  const PersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class ChangeNameEvent extends PersonalInfoEvent {
  final String value;

  ChangeNameEvent(this.value);
}

class ChangeFirstnameEvent extends PersonalInfoEvent {
  final String value;

  ChangeFirstnameEvent(this.value);
}

class ChangeSecondname extends PersonalInfoEvent {
  final String value;

  ChangeSecondname(this.value);
}

class ChangeBornDateEvent extends PersonalInfoEvent {
  final DateTime value;

  ChangeBornDateEvent(this.value);
}

class SaveEvent extends PersonalInfoEvent {}
