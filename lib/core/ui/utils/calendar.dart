import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class CalendarUtils {
  static showCalendarDatePicker(
    BuildContext context, {
    required DateTime minDate,
    required DateTime maxDate,
    required Function(DateTime) onConfirm,
    DateTime? initialDate,
  }) {
    final appColors = context.appColors;

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
