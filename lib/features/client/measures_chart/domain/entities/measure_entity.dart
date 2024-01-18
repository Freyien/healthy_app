import 'package:equatable/equatable.dart';

class MeasureEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String key;
  final String measure;
  final String text;
  final num value;

  const MeasureEntity({
    required this.id,
    required this.imageUrl,
    required this.key,
    required this.measure,
    required this.text,
    required this.value,
  });

  MeasureEntity copyWith({
    String? id,
    String? imageUrl,
    String? key,
    String? measure,
    String? text,
    num? value,
  }) {
    return MeasureEntity(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      key: key ?? this.key,
      measure: measure ?? this.measure,
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'key': key,
      'measure': measure,
      'text': text,
      'value': value,
    };
  }

  factory MeasureEntity.fromMap(Map<String, dynamic> map) {
    return MeasureEntity(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      key: map['key'] as String,
      measure: map['measure'] as String,
      text: map['text'] as String,
      value: map['value'] as num,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      imageUrl,
      key,
      measure,
      text,
      value,
    ];
  }
}
