import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/utils/enum_utils.dart';

class AppointmentEntity extends Equatable {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String notes;
  final AppointmentStatus status;

  const AppointmentEntity({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.notes,
    required this.status,
  });

  factory AppointmentEntity.initial() => AppointmentEntity(
        id: '',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        notes: '',
        status: AppointmentStatus.none,
      );

  AppointmentEntity copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    String? notes,
    AppointmentStatus? status,
  }) {
    return AppointmentEntity(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch,
      'notes': notes,
      'status': status.name,
    };
  }

  factory AppointmentEntity.fromMap(Map<String, dynamic> map) {
    final startTime = map['startTime'] is Timestamp
        ? (map['startTime'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(map['startTime'] * 1000);

    final endTime = map['endTime'] is Timestamp
        ? (map['endTime'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(map['endTime'] * 1000);

    return AppointmentEntity(
      id: map['id'],
      startTime: startTime,
      endTime: endTime,
      notes: map['notes'] ?? '',
      status: EnumUtils.stringToEnum(
            AppointmentStatus.values,
            map['status'],
          ) ??
          AppointmentStatus.scheduled,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      startTime,
      endTime,
      notes,
      status,
    ];
  }
}

enum AppointmentStatus { none, scheduled, pendingConfirmation, confirmed }
