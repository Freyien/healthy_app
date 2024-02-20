import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/utils/calendar.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';

class WaterPlanCalendarButton extends StatelessWidget {
  const WaterPlanCalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
    );
  }
}
