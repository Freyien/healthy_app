part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.client,
    required this.clientStatus,
    required this.signOutStatus,
    required this.versionStatus,
    required this.appVersion,
  });

  final ClientEntity client;
  final FetchingStatus clientStatus;

  final SignOutStatus signOutStatus;
  final FetchingStatus versionStatus;
  final String appVersion;

  factory SettingsState.initial() => SettingsState(
        client: ClientEntity.initial(),
        clientStatus: FetchingStatus.initial,
        signOutStatus: SignOutStatus.initial,
        versionStatus: FetchingStatus.initial,
        appVersion: '',
      );

  SettingsState copyWith({
    ClientEntity? client,
    FetchingStatus? clientStatus,
    SignOutStatus? signOutStatus,
    FetchingStatus? versionStatus,
    String? appVersion,
  }) {
    return SettingsState(
      client: client ?? this.client,
      clientStatus: clientStatus ?? this.clientStatus,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      versionStatus: versionStatus ?? this.versionStatus,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object> get props {
    return [
      client,
      clientStatus,
      signOutStatus,
      versionStatus,
      appVersion,
    ];
  }
}
