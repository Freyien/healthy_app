import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarUtils {
  static showCalendarDatePicker(
    BuildContext context, {
    required DateTime minDate,
    required DateTime maxDate,
    required Function(DateTime) onConfirm,
    required DateTime initialDate,
  }) {
    final appColors = context.appColors;

    DateTime selectedDate = initialDate;

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(4, 0, 4, 0),
          content: SizedBox(
            width: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatefulBuilder(builder: (context, setState) {
                    return TableCalendar(
                      firstDay: minDate,
                      lastDay: maxDate,
                      focusedDay: selectedDate,
                      currentDay: selectedDate,
                      weekendDays: [],
                      locale: 'es_Mx',
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          selectedDate = selectedDay;
                        });
                      },
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                      ),
                      rowHeight: 40,
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: appColors.primary,
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle: TextStyle(
                          color: appColors.textContrast,
                        ),
                        outsideTextStyle: TextStyle(
                          color: appColors.textContrast!.withOpacity(.5),
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          final now = DateTime.now().removeTime();

                          if (day.removeTime() == now)
                            return Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: appColors.primary!,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(
                                  color: appColors.primary,
                                ),
                              ),
                            );

                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              day.day.toString(),
                            ),
                          );
                        },
                        todayBuilder: (context, day, focusedDay) {
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: appColors.primary!,
                            ),
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                        dowBuilder: (context, day) {
                          final now = DateTime.now();
                          final name =
                              day.format('EEEE').toUpperCase().substring(0, 3);

                          final color = now.weekday == day.weekday
                              ? appColors.primary
                              : appColors.textContrast;

                          return Text(
                            name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                'CANCELAR',
                style: TextStyle(
                  color: appColors.textContrast!.withOpacity(.5),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                onConfirm(selectedDate);
              },
              child: Text(
                'ACEPTAR',
                style: TextStyle(
                  color: appColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );

    DatePicker.showDatePicker(
      context,
      locale: DateTimePickerLocale.es,
      initialDateTime: initialDate,
      minDateTime: minDate,
      maxDateTime: maxDate,
      pickerTheme: DateTimePickerTheme(
        backgroundColor: appColors.scaffold!,
        itemTextStyle: TextStyle(
          color: appColors.textContrast,
          fontSize: 16.0,
        ),
        confirmTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        selectionOverlay: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: appColors.border!),
            ),
          ),
        ),
      ),
      dateFormat: 'dd|MMMM,yyyy',
      onConfirm: (date, _) => onConfirm(date),
    );
  }
}
