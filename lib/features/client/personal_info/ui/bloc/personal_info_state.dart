part of 'personal_info_bloc.dart';

class PersonalInfoState extends Equatable {
  final FetchingStatus fetchingStatus;
  final SavingStatus savingStatus;
  final PersonalInfoEntity personalInfo;

  const PersonalInfoState({
    required this.fetchingStatus,
    required this.savingStatus,
    required this.personalInfo,
  });

  factory PersonalInfoState.initial() => PersonalInfoState(
        fetchingStatus: FetchingStatus.initial,
        personalInfo: PersonalInfoEntity.initial(),
        savingStatus: SavingStatus.initial,
      );

  PersonalInfoState copyWith({
    FetchingStatus? fetchingStatus,
    SavingStatus? savingStatus,
    PersonalInfoEntity? personalInfo,
  }) {
    return PersonalInfoState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      personalInfo: personalInfo ?? this.personalInfo,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, savingStatus, personalInfo];
}
