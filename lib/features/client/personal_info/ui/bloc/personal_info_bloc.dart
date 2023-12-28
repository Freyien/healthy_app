import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/features/client/personal_info/domain/entities/personal_info_entity.dart';
import 'package:healthy_app/features/client/personal_info/domain/repositories/personal_info_repository.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final PersonalInfoRepository _repository;

  PersonalInfoBloc(this._repository) : super(PersonalInfoState.initial()) {
    on<ChangeNameEvent>(_onChangeNameEvent);
    on<ChangeFirstnameEvent>(_onChangeFirstnameEvent);
    on<ChangeSecondname>(_onChangeSecondname);
    on<ChangeBornDateEvent>(_onChangeBornDateEvent);
    on<SaveEvent>(_onSaveEvent);
  }

  void _onChangeNameEvent(
    ChangeNameEvent event,
    Emitter<PersonalInfoState> emit,
  ) {
    emit(state.copyWith(
      personalInfo: state.personalInfo.copyWith(
        name: event.value,
      ),
    ));
  }

  void _onChangeFirstnameEvent(
    ChangeFirstnameEvent event,
    Emitter<PersonalInfoState> emit,
  ) {
    emit(state.copyWith(
      personalInfo: state.personalInfo.copyWith(
        firstname: event.value,
      ),
    ));
  }

  void _onChangeSecondname(
    ChangeSecondname event,
    Emitter<PersonalInfoState> emit,
  ) {
    emit(state.copyWith(
      personalInfo: state.personalInfo.copyWith(
        secondname: event.value,
      ),
    ));
  }

  void _onChangeBornDateEvent(
    ChangeBornDateEvent event,
    Emitter<PersonalInfoState> emit,
  ) {
    emit(state.copyWith(
      personalInfo: state.personalInfo.copyWith(
        bornDate: event.value,
      ),
    ));
  }

  Future<void> _onSaveEvent(
    SaveEvent event,
    Emitter<PersonalInfoState> emit,
  ) async {
    emit(state.copyWith(savingStatus: SavingStatus.loading));

    final response = await _repository.savePersonalInfo(state.personalInfo);

    if (response.isSuccess)
      return emit(state.copyWith(savingStatus: SavingStatus.success));

    emit(state.copyWith(savingStatus: SavingStatus.failure));
  }
}
