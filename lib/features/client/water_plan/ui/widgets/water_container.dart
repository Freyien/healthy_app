import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_plan_entity.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaterContainer extends StatelessWidget {
  const WaterContainer({super.key, required this.waterPlan});

  final WaterPlanEntity waterPlan;

  double _getHeightPercent(int percent) {
    final factor = percent >= 10 ? .1 : 0;

    if (percent >= 100) return -0.2;

    return 1 - (percent / 100) - factor;
  }

  @override
  Widget build(BuildContext context) {
    final percent = waterPlan.totalWaterConsumptionPercent;
    final heightPercent = _getHeightPercent(percent);

    return Stack(
      children: [
        // Wave
        Align(
          child: Container(
            height: 270,
            width: 270,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            child: ClipOval(
              child: TweenAnimationBuilder(
                curve: Curves.ease,
                duration: const Duration(seconds: 2),
                tween: Tween<double>(begin: 1, end: heightPercent),
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return WaveWidget(
                    config: CustomConfig(
                      colors: [
                        Colors.blue.withOpacity(.5),
                        Colors.blue.withOpacity(.9),
                      ],
                      durations: [
                        5000,
                        4000,
                      ],
                      heightPercentages: [
                        value,
                        value + .01,
                      ],
                    ),
                    backgroundColor: Colors.blueGrey.withOpacity(.2),
                    size: Size(double.infinity, double.infinity),
                  );
                },
              ),
            ),
          ),
        ),

        // Text
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedDigitWidget(
                    duration: Duration(seconds: 1),
                    value: percent,
                    textStyle: TextStyle(
                      color: context.appColors.textContrast,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '%',
                    style: TextStyle(
                      color: context.appColors.textContrast,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedDigitWidget(
                    duration: Duration(seconds: 1),
                    value: waterPlan.totalWaterConsumption,
                    textStyle: TextStyle(
                      color: context.appColors.textContrast,
                      fontSize: 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    ' ml',
                    style: TextStyle(
                      color: context.appColors.textContrast,
                      fontSize: 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
