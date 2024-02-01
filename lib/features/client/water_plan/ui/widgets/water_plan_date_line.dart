import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';

class WaterPlanDateLine extends StatelessWidget {
  const WaterPlanDateLine({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final controller = EasyInfiniteDateTimelineController();
    final timeLineHeight = height - 8;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocConsumer<WaterPlanBloc, WaterPlanState>(
          listenWhen: (p, c) => p.date != c.date,
          listener: (context, state) {
            controller.animateToDate(state.date);
          },
          buildWhen: (p, c) => p.date != c.date,
          builder: (context, state) {
            final now = DateTime.now();
            final focusDate = state.date;

            return LayoutBuilder(builder: (context, constraints) {
              return EasyInfiniteDateTimeLine(
                locale: 'es_MX',
                controller: controller,
                firstDate: state.minDate,
                focusDate: focusDate,
                lastDate: state.maxDate,
                dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayStrDayNumMonth,
                  width: constraints.maxWidth / 7 - 8.2,
                  landScapeMode: false,
                  borderColor: Colors.transparent,
                  height: timeLineHeight,
                ),
                itemBuilder:
                    (_, dayNumber, dayName, monthName, date, isSelected) {
                  final nowWeekday = now.weekday;
                  final isSameWeekday = nowWeekday == date.weekday;
                  final isToday = date.removeTime() == now.removeTime();

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected ? context.appColors.water : null,
                      border: isToday
                          ? Border.all(
                              color: context.appColors.water!,
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          dayName,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : isSameWeekday
                                    ? context.appColors.water
                                    : context.appColors.textContrast!
                                        .withOpacity(.7),
                            fontSize: 11,
                            fontWeight: isSameWeekday
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                        Text(
                          dayNumber,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : null,
                          ),
                        ),
                        Text(
                          monthName,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : context.appColors.textContrast!
                                    .withOpacity(.7),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                timeLineProps: EasyTimeLineProps(),
                showTimelineHeader: false,
                onDateChange: (selectedDate) {
                  context
                      .read<WaterPlanBloc>()
                      .add(GetWaterPlanEvent(selectedDate));
                },
              );
            });
          },
        ),
        VerticalSpace.small(),
      ],
    );
  }
}
