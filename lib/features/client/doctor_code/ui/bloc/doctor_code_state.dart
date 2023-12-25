part of 'doctor_code_bloc.dart';

class DoctorCodeState extends Equatable {
  const DoctorCodeState({
    required this.fetchingStatus,
    required this.client,
    required this.savingStatus,
    required this.code,
  });

  final FetchingStatus fetchingStatus;
  final ClientEntity client;

  final SavingStatus savingStatus;
  final String code;

  factory DoctorCodeState.initial() => DoctorCodeState(
        fetchingStatus: FetchingStatus.initial,
        client: ClientEntity.initial(),
        savingStatus: SavingStatus.initial,
        code: '',
      );

  DoctorCodeState copyWith({
    FetchingStatus? fetchingStatus,
    ClientEntity? client,
    SavingStatus? savingStatus,
    String? code,
  }) {
    return DoctorCodeState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      client: client ?? this.client,
      savingStatus: savingStatus ?? this.savingStatus,
      code: code ?? this.code,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, client, savingStatus, code];
}
