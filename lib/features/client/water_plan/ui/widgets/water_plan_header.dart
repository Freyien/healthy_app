import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_plan_entity.dart';

class WaterPlanHeader extends StatelessWidget {
  const WaterPlanHeader({super.key, required this.waterPlan});

  final WaterPlanEntity waterPlan;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                '${waterPlan.water} ml',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: context.appColors.textContrast,
                ),
              ),
              Text(
                'Objetivo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textContrast!.withOpacity(.7),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedDigitWidget(
                    value: waterPlan.remainingWaterConsumption,
                    duration: Duration(seconds: 1),
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: context.appColors.textContrast,
                        ),
                  ),
                  Text(
                    ' ml',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: context.appColors.textContrast,
                    ),
                  ),
                ],
              ),
              Text(
                'Restante',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textContrast!.withOpacity(.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
