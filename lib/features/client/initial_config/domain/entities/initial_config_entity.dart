import 'package:equatable/equatable.dart';

class InitialConfigEntity extends Equatable {
  final bool personalInfo;
  final bool doctorCode;

  InitialConfigEntity({
    required this.personalInfo,
    required this.doctorCode,
  });

  factory InitialConfigEntity.initial() => InitialConfigEntity(
        personalInfo: false,
        doctorCode: false,
      );

  InitialConfigEntity copyWith({
    bool? personalInfo,
    bool? doctorCode,
  }) {
    return InitialConfigEntity(
      personalInfo: personalInfo ?? this.personalInfo,
      doctorCode: doctorCode ?? this.doctorCode,
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
    );
  }

  @override
  List<Object> get props => [
        personalInfo,
        doctorCode,
      ];
}
