import 'package:equatable/equatable.dart';

class InitialConfigEntity extends Equatable {
  final bool personalInfo;
  final bool doctorCode;
  final int eatingPlanVersion;

  InitialConfigEntity({
    required this.personalInfo,
    required this.doctorCode,
    required this.eatingPlanVersion,
  });

  factory InitialConfigEntity.initial() => InitialConfigEntity(
        personalInfo: false,
        doctorCode: false,
        eatingPlanVersion: 0,
      );

  InitialConfigEntity copyWith({
    bool? personalInfo,
    bool? doctorCode,
    int? eatingPlanVersion,
  }) {
    return InitialConfigEntity(
      personalInfo: personalInfo ?? this.personalInfo,
      doctorCode: doctorCode ?? this.doctorCode,
      eatingPlanVersion: eatingPlanVersion ?? this.eatingPlanVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'personalInfo': personalInfo,
      'doctorCode': doctorCode,
    };
  }

  factory InitialConfigEntity.fromMap(Map<String, dynamic> map) {
    return InitialConfigEntity(
      personalInfo: map['personalInfo'] ?? false,
      doctorCode: map['doctorCode'] ?? false,
      eatingPlanVersion: map['eatingPlanVersion'] ?? 0,
    );
  }

  @override
  List<Object> get props => [
        personalInfo,
        doctorCode,
        eatingPlanVersion,
      ];
}
