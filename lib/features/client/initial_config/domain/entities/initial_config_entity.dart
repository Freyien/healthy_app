import 'package:equatable/equatable.dart';

class InitialConfigEntity extends Equatable {
  final bool emailVerified;
  final bool personalInfo;
  final bool doctorCode;

  InitialConfigEntity({
    required this.emailVerified,
    required this.personalInfo,
    required this.doctorCode,
  });

  factory InitialConfigEntity.initial() => InitialConfigEntity(
        emailVerified: true,
        personalInfo: false,
        doctorCode: false,
      );

  InitialConfigEntity copyWith({
    bool? emailVerified,
    bool? personalInfo,
    bool? doctorCode,
  }) {
    return InitialConfigEntity(
      emailVerified: emailVerified ?? this.emailVerified,
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
      emailVerified: map['emailVerified'] ?? true,
      personalInfo: map['personalInfo'] ?? false,
      doctorCode: map['doctorCode'] ?? false,
    );
  }

  @override
  List<Object> get props => [emailVerified, personalInfo, doctorCode];
}
