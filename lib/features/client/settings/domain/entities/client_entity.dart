import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String id;
  final String email;
  final String fullName;

  const ClientEntity({
    required this.id,
    required this.email,
    required this.fullName,
  });

  factory ClientEntity.initial() => ClientEntity(
        id: '',
        email: '',
        fullName: '',
      );

  ClientEntity copyWith({
    String? id,
    String? email,
    String? fullName,
  }) {
    return ClientEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'fullName': fullName,
    };
  }

  factory ClientEntity.fromMap(Map<String, dynamic> map) {
    return ClientEntity(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
    );
  }

  @override
  List<Object> get props => [id, email, fullName];
}
