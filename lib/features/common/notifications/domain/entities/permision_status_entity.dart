import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionStatusEntity extends Equatable {
  final NotificationPermissionStatus status;

  const PermissionStatusEntity({
    required this.status,
  });

  factory PermissionStatusEntity.initial() => PermissionStatusEntity(
        status: NotificationPermissionStatus.denied,
      );

  factory PermissionStatusEntity.fromPermissionStatus(PermissionStatus status) {
    NotificationPermissionStatus permissionStatus;

    switch (status) {
      case PermissionStatus.denied:
        permissionStatus = NotificationPermissionStatus.denied;
        break;
      case PermissionStatus.granted:
        permissionStatus = NotificationPermissionStatus.granted;
        break;
      case PermissionStatus.restricted:
        permissionStatus = NotificationPermissionStatus.unknow;
        break;
      case PermissionStatus.limited:
        permissionStatus = NotificationPermissionStatus.unknow;
        break;
      case PermissionStatus.permanentlyDenied:
        permissionStatus = NotificationPermissionStatus.permanentlyDenied;
        break;
      case PermissionStatus.provisional:
        permissionStatus = NotificationPermissionStatus.unknow;
        break;
    }

    return PermissionStatusEntity(
      status: permissionStatus,
    );
  }

  bool get isDenied => status == NotificationPermissionStatus.denied;

  bool get isgranted => status == NotificationPermissionStatus.granted;

  bool get ispermanentlyDenied =>
      status == NotificationPermissionStatus.permanentlyDenied;

  bool get isunknow => status == NotificationPermissionStatus.unknow;

  @override
  List<Object> get props => [status];
}

enum NotificationPermissionStatus {
  denied,
  granted,
  permanentlyDenied,
  unknow,
}
