import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_button.dart';

class WaterPlanButtons extends StatelessWidget {
  const WaterPlanButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final buttonWidth = constraints.maxWidth * .5 - 8;

        return Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runSpacing: 16,
          spacing: 16,
          children: [
            WaterButton(
              width: buttonWidth,
              onPressed: () => _addWaterConsumption(context, 250),
              imageName: 'vaso',
              text: '250 ml',
            ),
            WaterButton(
              width: buttonWidth,
              onPressed: () => _addWaterConsumption(context, 500),
              imageName: 'agua',
              text: '500 ml',
            ),
            WaterButton(
              width: buttonWidth,
              onPressed: () => _addWaterConsumption(context, 600),
              imageName: 'agua',
              text: '600 ml',
            ),
            WaterButton(
              width: buttonWidth,
              onPressed: () {
                context.read<WaterPlanBloc>().add(AddWaterConsumptionEvent(0));
              },
              imageName: 'gota-de-agua',
              text: 'otro',
            ),
          ],
        );
      },
    );
  }

  void _addWaterConsumption(BuildContext context, int quantity) {
    context.read<WaterPlanBloc>().add(AddWaterConsumptionEvent(quantity));
  }
}
