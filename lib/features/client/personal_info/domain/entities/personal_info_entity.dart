import 'package:equatable/equatable.dart';

class PersonalInfoEntity extends Equatable {
  final String name;
  final String firstname;
  final String secondname;
  final DateTime? bornDate;

  PersonalInfoEntity({
    required this.name,
    required this.firstname,
    required this.secondname,
    this.bornDate,
  });

  factory PersonalInfoEntity.initial() => PersonalInfoEntity(
        name: '',
        firstname: '',
        secondname: '',
      );

  PersonalInfoEntity copyWith({
    String? name,
    String? firstname,
    String? secondname,
    DateTime? bornDate,
  }) {
    return PersonalInfoEntity(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      secondname: secondname ?? this.secondname,
      bornDate: bornDate ?? this.bornDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name.trim(),
      'firstname': firstname.trim(),
      'secondname': secondname.trim(),
      'bornDate': bornDate?.millisecondsSinceEpoch,
    };
  }

  factory PersonalInfoEntity.fromMap(Map<String, dynamic> map) {
    return PersonalInfoEntity(
      name: map['name'] ?? '',
      firstname: map['firstname'] ?? '',
      secondname: map['secondname'] ?? '',
      bornDate: map['bornDate'] != null //
          ? DateTime.fromMillisecondsSinceEpoch(map['bornDate'] as int)
          : null,
    );
  }

  @override
  List<Object?> get props => [name, firstname, secondname, bornDate];
}
