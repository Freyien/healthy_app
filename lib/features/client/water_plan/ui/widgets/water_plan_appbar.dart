import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/calendar.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';

class WaterPlanAppBarTitle extends StatelessWidget {
  const WaterPlanAppBarTitle({super.key});

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
        BlocBuilder<WaterPlanBloc, WaterPlanState>(
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
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            final bloc = context.read<WaterPlanBloc>();

            CalendarUtils.showCalendarDatePicker(
              context,
              minDate: bloc.state.minDate,
              maxDate: bloc.state.maxDate,
              initialDate: bloc.state.date,
              onConfirm: (date) {
                bloc.add(GetWaterPlanEvent(date));
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
