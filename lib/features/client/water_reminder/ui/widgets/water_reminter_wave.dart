import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaterReminderWave extends StatelessWidget {
  const WaterReminderWave({super.key});

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        colors: [
          Colors.blue.withOpacity(.2),
          Colors.blue.withOpacity(.3),
        ],
        durations: [
          4500,
          3500,
        ],
        heightPercentages: [
          .89,
          .90,
        ],
      ),
      size: Size(double.infinity, double.infinity),
    );
  }
}
