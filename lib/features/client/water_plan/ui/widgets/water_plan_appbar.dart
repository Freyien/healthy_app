import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/calendar.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';

class WaterPlanAppBarTitle extends StatelessWidget {
  const WaterPlanAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          IconButton(
            onPressed: () {
              final bloc = context.read<WaterPlanBloc>();
              final date = bloc.state.date;

              bloc.add(GetWaterPlanEvent(date.subtract(Duration(
                days: 1,
              ))));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          BlocBuilder<WaterPlanBloc, WaterPlanState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  CalendarUtils.showCalendarDatePicker(
                    context,
                    minDate: DateTime(2024),
                    maxDate: DateTime.now().add(Duration(days: 60)),
                    onConfirm: (date) {
                      context
                          .read<WaterPlanBloc>()
                          .add(GetWaterPlanEvent(date));
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
              final bloc = context.read<WaterPlanBloc>();
              final date = bloc.state.date;

              bloc.add(GetWaterPlanEvent(date.add(
                Duration(days: 1),
              )));
            },
            icon: Icon(Icons.arrow_forward_ios),
          ),
          Spacer(flex: 1),
          IconButton(
            onPressed: () {
              CalendarUtils.showCalendarDatePicker(
                context,
                minDate: DateTime(2024),
                maxDate: DateTime.now().add(Duration(days: 60)),
                onConfirm: (date) {
                  context.read<WaterPlanBloc>().add(GetWaterPlanEvent(date));
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
