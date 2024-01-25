import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarUtils {
  static showCalendarDatePicker(
    BuildContext context, {
    required DateTime minDate,
    required DateTime maxDate,
    required Function(DateTime) onConfirm,
    required DateTime initialDate,
    DateRangePickerView view = DateRangePickerView.month,
  }) {
    final appColors = context.appColors;

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
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 4),
          content: SizedBox(
            width: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SfDateRangePicker(
                    backgroundColor: Colors.transparent,
                    minDate: minDate,
                    maxDate: maxDate,
                    initialDisplayDate: initialDate,
                    initialSelectedDate: initialDate,
                    initialSelectedDates: [initialDate],
                    view: view,
                    allowViewNavigation: true,
                    enablePastDates: true,
                    showNavigationArrow: true,
                    showActionButtons: true,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      showTrailingAndLeadingDates: true,
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle: TextStyle(
                          color: appColors.textContrast,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    headerStyle: DateRangePickerHeaderStyle(
                      textStyle: TextStyle(
                        color: appColors.textContrast,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                    yearCellStyle: DateRangePickerYearCellStyle(
                      textStyle: TextStyle(
                        color: appColors.textContrast,
                      ),
                      disabledDatesTextStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      leadingDatesTextStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      textStyle: TextStyle(
                        color: appColors.textContrast,
                      ),
                      leadingDatesTextStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                      trailingDatesTextStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                      disabledDatesTextStyle: TextStyle(
                        color: Colors.transparent,
                      ),
                    ),
                    selectionColor: appColors.primary,
                    todayHighlightColor: appColors.primary,
                    onSubmit: (value) {
                      onConfirm(value as DateTime);
                      Navigator.pop(dialogContext);
                    },
                    onCancel: () => Navigator.pop(dialogContext),
                    cancelText: 'CANCELAR',
                    confirmText: 'CONFIRMAR',
                  ),
                ],
              ),
            ),
          ),
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
