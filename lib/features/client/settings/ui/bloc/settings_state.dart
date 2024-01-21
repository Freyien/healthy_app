part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.signOutStatus = SignOutStatus.initial,
    this.versionStatus = FetchingStatus.initial,
    this.appVersion = '',
  });

  final SignOutStatus signOutStatus;
  final FetchingStatus versionStatus;
  final String appVersion;

  SettingsState copyWith({
    SignOutStatus? signOutStatus,
    FetchingStatus? versionStatus,
    String? appVersion,
  }) =>
      SettingsState(
        signOutStatus: signOutStatus ?? this.signOutStatus,
        versionStatus: versionStatus ?? this.versionStatus,
        appVersion: appVersion ?? this.appVersion,
      );

  @override
  List<Object> get props => [signOutStatus, versionStatus, appVersion];
}
