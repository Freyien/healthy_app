part of 'initial_config_bloc.dart';

class InitialConfigState extends Equatable {
  const InitialConfigState({
    required this.fetchingStatus,
    required this.initialConfig,
  });

  final FetchingStatus fetchingStatus;
  final InitialConfigEntity initialConfig;

  factory InitialConfigState.initial() => InitialConfigState(
        fetchingStatus: FetchingStatus.initial,
        initialConfig: InitialConfigEntity.initial(),
      );

  InitialConfigState copyWith({
    FetchingStatus? fetchingStatus,
    InitialConfigEntity? initialConfig,
  }) {
    return InitialConfigState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      initialConfig: initialConfig ?? this.initialConfig,
    );
  }

  @override
  List<Object> get props => [fetchingStatus, initialConfig];
}
