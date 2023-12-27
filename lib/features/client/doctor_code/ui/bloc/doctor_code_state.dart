part of 'doctor_code_bloc.dart';

class DoctorCodeState extends Equatable {
  const DoctorCodeState({
    required this.savingStatus,
    required this.code,
    required this.failure,
  });

  final SavingStatus savingStatus;
  final String code;
  final Failure failure;

  factory DoctorCodeState.initial() => DoctorCodeState(
        savingStatus: SavingStatus.initial,
        code: '',
        failure: NoneFailure(),
      );

  DoctorCodeState copyWith({
    SavingStatus? savingStatus,
    String? code,
    Failure? failure,
  }) {
    return DoctorCodeState(
      savingStatus: savingStatus ?? this.savingStatus,
      code: code ?? this.code,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [savingStatus, code, failure];
}
