import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';

class WaterPlanCurrentDay extends StatelessWidget {
  const WaterPlanCurrentDay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterPlanBloc, WaterPlanState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            final now = DateTime.now().removeTime();

            final bloc = context.read<WaterPlanBloc>();
            bloc.add(GetWaterPlanEvent(now));
          },
          child: Text(
            state.date.format('MMMMd'),
            style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  color: context.appColors.textContrast,
                ),
          ),
        );
      },
    );
  }
}
