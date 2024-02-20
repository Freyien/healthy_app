import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';
import 'package:intl/intl.dart';

class EatingTrophyButton extends StatelessWidget {
  const EatingTrophyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EatingPlanBloc, EatingPlanState>(
      builder: (context, state) {
        final showSuccessButton = state.eatingPlan.isPlanComplete;

        if (!showSuccessButton) return SizedBox.shrink();

        return TrophyButton(
          onTap: () => _goToWaterSuccess(context),
        );
      },
    );
  }

  void _goToWaterSuccess(BuildContext context) {
    final state = context.read<EatingPlanBloc>().state;
    final date = state.date;
    final dayOfWeek = 367 - int.parse(DateFormat('D').format(date));

    final message = HealthyConstants.eatingSuccessMessageList[dayOfWeek - 1];
    final imageName = 'trophy-$dayOfWeek';
    final subtitle = '';

    final extra = {
      'date': date.millisecondsSinceEpoch,
      'imageName': imageName,
      'message': message,
      'subtitle': subtitle,
    };

    context.goNamed('eating_success', extra: json.encode(extra));
  }
}
