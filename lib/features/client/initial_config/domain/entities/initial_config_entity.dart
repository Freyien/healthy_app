import 'package:equatable/equatable.dart';

class InitialConfigEntity extends Equatable {
  final String doctorId;

  InitialConfigEntity({
    required this.doctorId,
  });

  factory InitialConfigEntity.initial() => InitialConfigEntity(
        doctorId: '',
      );

  NextPage get nextPage {
    return doctorId.isEmpty //
        ? NextPage.doctorCode
        : NextPage.home;
  }

  InitialConfigEntity copyWith({
    String? doctorId,
  }) {
    return InitialConfigEntity(
      doctorId: doctorId ?? this.doctorId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctorId': doctorId,
    };
  }

  factory InitialConfigEntity.fromMap(Map<String, dynamic> map) {
    return InitialConfigEntity(
      doctorId: map['doctorId'] ?? '',
    );
  }

  @override
  List<Object> get props => [doctorId];
}

enum NextPage { doctorCode, home }
