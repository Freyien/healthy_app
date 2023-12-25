import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String id;
  final String doctorId;

  ClientEntity({
    required this.id,
    required this.doctorId,
  });

  factory ClientEntity.initial() => ClientEntity(
        id: '',
        doctorId: '',
      );

  ClientEntity copyWith({
    String? id,
    String? doctorId,
  }) {
    return ClientEntity(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'doctorId': doctorId,
    };
  }

  factory ClientEntity.fromMap(Map<String, dynamic> map) {
    return ClientEntity(
      id: map['id'] ?? '',
      doctorId: map['doctorId'] ?? '',
    );
  }

  @override
  List<Object> get props => [id, doctorId];
}
