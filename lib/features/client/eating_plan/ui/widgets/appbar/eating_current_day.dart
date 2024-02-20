import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';

class EatingCurrentDay extends StatelessWidget {
  const EatingCurrentDay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EatingPlanBloc, EatingPlanState>(
      buildWhen: (p, c) => p.date != c.date,
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            final now = DateTime.now().removeTime();

            final bloc = context.read<EatingPlanBloc>();
            bloc.add(GetEatingPlanEvent(now));
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
