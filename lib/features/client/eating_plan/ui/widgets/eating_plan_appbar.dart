import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/calendar.dart';
import 'package:healthy_app/core/ui/widgets/horizontal_space.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';

class EatingPlanAppBarTitle extends StatelessWidget {
  const EatingPlanAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HorizontalSpace.xsmall(),
        Opacity(
          opacity: 0,
          child: IconButton(
            onPressed: null,
            icon: Icon(Icons.calendar_month_outlined),
          ),
        ),
        Spacer(),
        BlocBuilder<EatingPlanBloc, EatingPlanState>(
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
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            final bloc = context.read<EatingPlanBloc>();

            CalendarUtils.showCalendarDatePicker(
              context,
              minDate: bloc.state.minDate,
              maxDate: bloc.state.maxDate,
              initialDate: bloc.state.date,
              onConfirm: (date) {
                bloc.add(GetEatingPlanEvent(date));
              },
            );
          },
          icon: Icon(Icons.calendar_month_outlined),
        ),
        HorizontalSpace.xsmall(),
      ],
    );
  }
}
