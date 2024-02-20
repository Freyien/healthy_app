import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/utils/calendar.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';

class EatingCalendarButton extends StatelessWidget {
  const EatingCalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
    );
  }
}
