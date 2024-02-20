import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';

class EatingConfetti extends StatelessWidget {
  const EatingConfetti({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EatingPlanBloc, EatingPlanState>(
      builder: (context, state) {
        if (state.fetchingStatus != FetchingStatus.success)
          return SizedBox.shrink();

        if (!state.eatingPlan.isPlanComplete) return SizedBox.shrink();

        return ConfettiBackground(
          showConfetti: state.eatingPlan.isPlanComplete,
          opacity: .4,
          delay: Duration(milliseconds: 1000),
        );
      },
    );
  }
}
