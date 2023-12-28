part of 'personal_info_bloc.dart';

class PersonalInfoState extends Equatable {
  final SavingStatus savingStatus;
  final PersonalInfoEntity personalInfo;

  const PersonalInfoState({
    required this.savingStatus,
    required this.personalInfo,
  });

  factory PersonalInfoState.initial() => PersonalInfoState(
        personalInfo: PersonalInfoEntity.initial(),
        savingStatus: SavingStatus.initial,
      );

  PersonalInfoState copyWith({
    SavingStatus? savingStatus,
    PersonalInfoEntity? personalInfo,
  }) {
    return PersonalInfoState(
      savingStatus: savingStatus ?? this.savingStatus,
      personalInfo: personalInfo ?? this.personalInfo,
    );
  }

  @override
  List<Object> get props => [savingStatus, personalInfo];
}
