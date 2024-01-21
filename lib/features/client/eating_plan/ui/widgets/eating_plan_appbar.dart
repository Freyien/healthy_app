import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/calendar.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';

class EatingPlanAppBarTitle extends StatelessWidget {
  const EatingPlanAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          IconButton(
            onPressed: () {
              final bloc = context.read<EatingPlanBloc>();
              final date = bloc.state.date;

              bloc.add(GetEatingPlanEvent(date.subtract(Duration(
                days: 1,
              ))));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          BlocBuilder<EatingPlanBloc, EatingPlanState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  final bloc = context.read<EatingPlanBloc>();

                  CalendarUtils.showCalendarDatePicker(
                    context,
                    minDate: DateTime(2024),
                    maxDate: DateTime.now().add(Duration(days: 60)),
                    initialDate: bloc.state.date,
                    onConfirm: (date) {
                      bloc.add(GetEatingPlanEvent(date));
                    },
                  );
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
          IconButton(
            onPressed: () {
              final bloc = context.read<EatingPlanBloc>();
              final date = bloc.state.date;

              bloc.add(GetEatingPlanEvent(date.add(
                Duration(days: 1),
              )));
            },
            icon: Icon(Icons.arrow_forward_ios),
          ),
          Spacer(flex: 1),
          IconButton(
            onPressed: () {
              final bloc = context.read<EatingPlanBloc>();

              CalendarUtils.showCalendarDatePicker(
                context,
                minDate: DateTime(2024),
                maxDate: DateTime.now().add(Duration(days: 60)),
                initialDate: bloc.state.date,
                onConfirm: (date) {
                  bloc.add(GetEatingPlanEvent(date));
                },
              );
            },
            icon: Icon(Icons.calendar_month_outlined),
          ),
        ],
      ),
    );
  }
}
