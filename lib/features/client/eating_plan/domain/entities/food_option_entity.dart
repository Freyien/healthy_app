// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:healthy_app/core/domain/utils/enum_utils.dart';

class FoodOptionEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String comment;
  final PortionFraction fraction;
  final PortionMeasure measure;
  final int portion;
  final bool checked;

  FoodOptionEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.comment,
    required this.fraction,
    required this.measure,
    required this.portion,
    required this.checked,
  });

  FoodOptionEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? comment,
    PortionFraction? fraction,
    PortionMeasure? measure,
    int? portion,
    bool? checked,
  }) {
    return FoodOptionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      comment: comment ?? this.comment,
      fraction: fraction ?? this.fraction,
      measure: measure ?? this.measure,
      portion: portion ?? this.portion,
      checked: checked ?? this.checked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'comment': comment,
      'fraction': fraction.name,
      'measure': measure.name,
      'portion': portion,
    };
  }

  factory FoodOptionEntity.fromMap(Map<String, dynamic> map) {
    final food = Map<String, dynamic>.from(map['food']);

    return FoodOptionEntity(
      id: food['id'] as String,
      name: food['name'] as String,
      imageUrl: food['imageUrl'] as String,
      comment: map['comment'] as String,
      fraction:
          EnumUtils.stringToEnum(PortionFraction.values, map['fraction']) ??
              PortionFraction.half,
      measure: EnumUtils.stringToEnum(PortionMeasure.values, map['measure']) ??
          PortionMeasure.grs,
      portion: map['portion'] as int,
      checked: false,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      imageUrl,
      comment,
      fraction,
      measure,
      portion,
      checked,
    ];
  }
}

enum PortionFraction {
  half,
  zero,
  oneQuarter,
  twoQuarters,
  threeQuarters,
  oneThird,
  twoThrids
}

enum PortionMeasure { cup, mls, grs, piece, tablespoon, teaspoonful }
