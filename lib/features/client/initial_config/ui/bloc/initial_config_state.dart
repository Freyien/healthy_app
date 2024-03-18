part of 'initial_config_bloc.dart';

class InitialConfigState extends Equatable {
  const InitialConfigState({
    required this.emailVerified,
    required this.emailVerifyStatus,
    required this.initialConfigStatus,
    required this.initialConfig,
    required this.completeOnboardingStatus,
  });

  final FetchingStatus emailVerifyStatus;
  final bool emailVerified;

  final FetchingStatus initialConfigStatus;
  final InitialConfigEntity initialConfig;

  final SavingStatus completeOnboardingStatus;

  factory InitialConfigState.initial() => InitialConfigState(
        emailVerified: true,
        emailVerifyStatus: FetchingStatus.initial,
        initialConfigStatus: FetchingStatus.initial,
        completeOnboardingStatus: SavingStatus.initial,
        initialConfig: InitialConfigEntity.initial(),
      );

  InitialConfigState copyWith({
    FetchingStatus? emailVerifyStatus,
    bool? emailVerified,
    FetchingStatus? initialConfigStatus,
    SavingStatus? finishOnboardingStatus,
    InitialConfigEntity? initialConfig,
  }) {
    return InitialConfigState(
      emailVerifyStatus: emailVerifyStatus ?? this.emailVerifyStatus,
      emailVerified: emailVerified ?? this.emailVerified,
      initialConfigStatus: initialConfigStatus ?? this.initialConfigStatus,
      completeOnboardingStatus:
          finishOnboardingStatus ?? this.completeOnboardingStatus,
      initialConfig: initialConfig ?? this.initialConfig,
    );
  }

  @override
  List<Object?> get props => [
        emailVerifyStatus,
        emailVerified,
        initialConfigStatus,
        completeOnboardingStatus,
        initialConfig,
      ];
}
