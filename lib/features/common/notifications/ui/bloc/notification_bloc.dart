import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/entities/initial_route_entity.dart';
import 'package:healthy_app/core/domain/usecases/get_initial_route_usecase.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/notification_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/entities/permision_status_entity.dart';
import 'package:healthy_app/features/common/notifications/domain/repositories/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;
  final GetInitialRouteUseCase _getInitialRouteUseCase;

  NotificationBloc(
    this._notificationRepository,
    this._getInitialRouteUseCase,
  ) : super(NotificationState.empty()) {
    on<RequestPermissionEvent>(_onRequestPermissionEvent);
    on<GetNextRouteEvent>(_onGetNextRouteEvent);
    on<CheckPermissionEvent>(_onCheckPermissionEvent);
    on<OpenNotificationSettingsEvent>(_onOpenNotificationSettingsEvent);

    on<InitRemoteNotificationsEvent>(_onInitRemoteNotificationsEvent);
    on<InitLocalNotificationsEvent>(_onInitLocalNotificationsEvent);
    on<SaveTokenEvent>(_onSaveTokenEvent);
    on<GetInitialMessageEvent>(_onGetInitialMessageEvent);
    on<ActionReceivedMethodEvent>(_onActionReceivedMethod);
    on<SuscribeToCommonTipics>(_onSuscribeToCommonTipics);
  }

  Future<void> _onRequestPermissionEvent(
    RequestPermissionEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final response = await _notificationRepository.requestPermission();

    if (response.isFailed) {
      return emit(state.copyWith(status: NotificationStatus.failure));
    }

    return emit(
      state.copyWith(
        status: NotificationStatus.permissionRequested,
      ),
    );
  }

  Future<void> _onGetNextRouteEvent(
    GetNextRouteEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      state.copyWith(status: NotificationStatus.loading),
    );

    try {
      final route =
          await _getInitialRouteUseCase.call(checkNotifications: false);

      emit(
        state.copyWith(
          route: route,
          status: NotificationStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NotificationStatus.failure,
        ),
      );
    }
  }

  Future<void> _onCheckPermissionEvent(
    CheckPermissionEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final response =
        await _notificationRepository.checkNotificationPermission();

    if (response.isFailed) {
      return emit(
        state.copyWith(status: NotificationStatus.failure),
      );
    }

    return emit(
      state.copyWith(
        permissionStatus: response.data,
        status: NotificationStatus.permissionChecked,
      ),
    );
  }

  Future<void> _onOpenNotificationSettingsEvent(
    OpenNotificationSettingsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final response = await _notificationRepository.openNotificationSettings();

    if (response.isFailed) {
      return emit(
        state.copyWith(status: NotificationStatus.failure),
      );
    }

    return emit(
      state.copyWith(
        status: NotificationStatus.settingsOpened,
      ),
    );
  }

  Future<void> _onInitRemoteNotificationsEvent(
    InitRemoteNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await _notificationRepository.initRemoteNotifications();
  }

  Future<void> _onInitLocalNotificationsEvent(
    InitLocalNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await _notificationRepository.initLocalNotifications();
  }

  Future<void> _onSaveTokenEvent(
    SaveTokenEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await _notificationRepository.saveToken();
  }

  Future<void> _onGetInitialMessageEvent(
    GetInitialMessageEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final response = await _notificationRepository.getInitialMessage();

    if (response.isFailed) {
      return emit(
        state.copyWith(status: NotificationStatus.failure),
      );
    }

    if (response.data == null) return;

    emit(
      state.copyWith(
        status: NotificationStatus.notificationTapped,
        notification: response.data,
      ),
    );
  }

  Future<void> _onActionReceivedMethod(
    ActionReceivedMethodEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await emit.forEach(
      _notificationRepository.onActionReceivedMethod(),
      onData: (notification) {
        return state.copyWith(
          notification: notification,
          status: NotificationStatus.notificationTapped,
        );
      },
    );
  }

  Future<void> _onSuscribeToCommonTipics(
    SuscribeToCommonTipics event,
    Emitter<NotificationState> emit,
  ) async {
    await _notificationRepository.suscribeToCommonTipics();
  }
}
