import 'package:equatable/equatable.dart';

class KeyValueEntity extends Equatable {
  final String key;
  final String value;

  KeyValueEntity({
    required this.key,
    required this.value,
  });

  KeyValueEntity copyWith({
    String? key,
    String? value,
  }) {
    return KeyValueEntity(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'key': key});
    result.addAll({'value': value});

    return result;
  }

  factory KeyValueEntity.fromMap(Map<String, dynamic> map) {
    return KeyValueEntity(
      key: map['key'] ?? '',
      value: map['value'] ?? '',
    );
  }

  @override
  List<Object> get props => [key, value];
}
