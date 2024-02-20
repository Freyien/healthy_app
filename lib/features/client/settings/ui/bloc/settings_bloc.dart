import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/signout_status.dart';
import 'package:healthy_app/features/client/settings/domain/entities/client_entity.dart';
import 'package:healthy_app/features/client/settings/domain/repositories/settings_repository.dart';
import 'package:healthy_app/features/client/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SignInRepository _authRepository;
  final SettingsRepository _settingsRepository;
  final NotificationRepository _notificationRepository;

  SettingsBloc(
    this._authRepository,
    this._settingsRepository,
    this._notificationRepository,
  ) : super(SettingsState.initial()) {
    on<SignOutEvent>(_onSignOutEvent);
    on<FetchAppVersionEvent>(_onFetchAppVersionEvent);
    on<GetClientEvent>(_onGetClientEvent);
  }

  Future<void> _onSignOutEvent(
    SignOutEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(
      signOutStatus: SignOutStatus.loading,
    ));

    try {
      await Future.wait([
        _notificationRepository.closeStreams(),
        _notificationRepository.unsuscribeToCommonTipics(),
        _notificationRepository.deleteToken(),
      ]);

      await _authRepository.signOut();
    } catch (e) {
      return emit(state.copyWith(
        signOutStatus: SignOutStatus.failure,
      ));
    }

    emit(state.copyWith(signOutStatus: SignOutStatus.closed));
  }

  Future<void> _onFetchAppVersionEvent(
    FetchAppVersionEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(
      versionStatus: FetchingStatus.loading,
    ));

    final response = _settingsRepository.fetchAppVersion();

    if (response.isSuccess) {
      return emit(state.copyWith(
        versionStatus: FetchingStatus.success,
        appVersion: response.data,
      ));
    }

    emit(state.copyWith(
      versionStatus: FetchingStatus.failure,
    ));
  }

  Future<void> _onGetClientEvent(
    GetClientEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(
      clientStatus: FetchingStatus.loading,
    ));

    final response = await _settingsRepository.getClient();

    if (response.isSuccess) {
      return emit(state.copyWith(
        clientStatus: FetchingStatus.success,
        client: response.data,
      ));
    }

    emit(state.copyWith(
      clientStatus: FetchingStatus.failure,
    ));
  }
}
