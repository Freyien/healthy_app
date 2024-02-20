import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';
import 'package:intl/intl.dart';

class WaterPlanTrophyButton extends StatelessWidget {
  const WaterPlanTrophyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterPlanBloc, WaterPlanState>(
      builder: (context, state) {
        if (state.waterPlan.water == 0) return SizedBox.shrink();

        final remainingWater = state.waterPlan.remainingWaterConsumption;
        final showSuccessButton = remainingWater == 0;

        if (!showSuccessButton) return SizedBox.shrink();

        return TrophyButton(
          onTap: () => _goToWaterSuccess(context),
        );
      },
    );
  }

  void _goToWaterSuccess(BuildContext context) {
    final state = context.read<WaterPlanBloc>().state;
    final date = state.date;
    final water = state.waterPlan.water / 1000;
    final dayOfWeek = int.parse(DateFormat('D').format(date));

    final message = HealthyConstants.waterSuccessMessageList[dayOfWeek - 1];
    final imageName = 'trophy-$dayOfWeek';
    final subtitle = '$water lts';

    final extra = {
      'date': date.millisecondsSinceEpoch,
      'imageName': imageName,
      'message': message,
      'subtitle': subtitle,
    };

    context.goNamed('water_success', extra: json.encode(extra));
  }
}
