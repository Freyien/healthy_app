part of 'initial_config_bloc.dart';

class InitialConfigState extends Equatable {
  const InitialConfigState({
    required this.emailVerified,
    required this.emailVerifyStatus,
    required this.initialConfigStatus,
    required this.initialConfig,
  });

  final FetchingStatus emailVerifyStatus;
  final bool emailVerified;

  final FetchingStatus initialConfigStatus;
  final InitialConfigEntity initialConfig;

  factory InitialConfigState.initial() => InitialConfigState(
        emailVerified: true,
        emailVerifyStatus: FetchingStatus.initial,
        initialConfigStatus: FetchingStatus.initial,
        initialConfig: InitialConfigEntity.initial(),
      );

  InitialConfigState copyWith({
    FetchingStatus? emailVerifyStatus,
    bool? emailVerified,
    FetchingStatus? initialConfigStatus,
    InitialConfigEntity? initialConfig,
  }) {
    return InitialConfigState(
      emailVerifyStatus: emailVerifyStatus ?? this.emailVerifyStatus,
      emailVerified: emailVerified ?? this.emailVerified,
      initialConfigStatus: initialConfigStatus ?? this.initialConfigStatus,
      initialConfig: initialConfig ?? this.initialConfig,
    );
  }

  @override
  List<Object?> get props => [
        emailVerifyStatus,
        emailVerified,
        initialConfigStatus,
        initialConfig,
      ];
}
