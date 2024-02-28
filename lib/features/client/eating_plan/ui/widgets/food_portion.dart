import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/eating_plan/domain/entities/food_option_entity.dart';

class FoodPortion extends StatelessWidget {
  const FoodPortion({
    super.key,
    required this.food,
  });

  final FoodOptionEntity food;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Portion
        if (portionText.isNotEmpty)
          Text(
            '${portionText} ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: context.appColors.textContrast,
              fontSize: 14,
            ),
          ),

        // Fraction
        if (portionName.isNotEmpty)
          Text(
            '${portionName} ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: context.appColors.textContrast,
              fontSize: 13,
            ),
          ),

        // Measure
        if (measureName.isNotEmpty)
          Text(
            measureName,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: context.appColors.textContrast,
              fontSize: 14,
            ),
          ),
      ],
    );
  }

  String get portionText {
    if (food.portion == 0) return '';

    return food.portion.toString();
  }

  String get portionName {
    switch (food.fraction) {
      case PortionFraction.zero:
        return '';
      case PortionFraction.half:
        return '1/2';
      case PortionFraction.oneQuarter:
        return '1/4';
      case PortionFraction.twoQuarters:
        return '2/4';
      case PortionFraction.threeQuarters:
        return '3/4';
      case PortionFraction.oneThird:
        return '1/3';
      case PortionFraction.twoThrids:
        return '2/3';
    }
  }

  String get measureName {
    bool isSingular = true;

    if (food.portion > 1) isSingular = false;

    switch (food.measure) {
      case PortionMeasure.grs:
        return 'grs';
      case PortionMeasure.mls:
        return 'mls';
      case PortionMeasure.piece:
        return isSingular ? 'pieza' : 'piezas';
      case PortionMeasure.cup:
        return isSingular ? 'taza' : 'tazas';
      case PortionMeasure.tablespoon:
        return isSingular ? 'cucharada' : 'cucharadas';
      case PortionMeasure.teaspoonful:
        return isSingular ? 'cucharadita' : 'cucharaditas';
    }
  }
}
