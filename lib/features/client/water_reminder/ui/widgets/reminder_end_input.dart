import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/extensions/string.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/water_reminder/ui/bloc/water_reminder_bloc.dart';

class ReminderEndInput extends StatelessWidget {
  const ReminderEndInput({super.key, required this.enable});

  final bool enable;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterReminderBloc, WaterReminderState>(
      buildWhen: (p, c) => p.waterReminder.end != c.waterReminder.end,
      builder: (context, state) {
        return InputText(
          key: UniqueKey(),
          hintText: '23:59',
          prefixIcon: Icon(Icons.access_time_outlined),
          readOnly: true,
          enabled: enable,
          initialValue: state.waterReminder.end.format('HH:mm'),
          onTap: () {
            DatePicker.showDatePicker(
              context,
              locale: DateTimePickerLocale.es,
              pickerMode: DateTimePickerMode.time,
              initialDateTime: state.waterReminder.end,
              minDateTime: DateTime.now().removeTime(),
              maxDateTime: DateTime.now().copyWith(hour: 23, minute: 59),
              pickerTheme: DateTimePickerTheme(
                backgroundColor: context.appColors.scaffold!,
                itemTextStyle: TextStyle(
                  color: context.appColors.textContrast,
                  fontSize: 16.0,
                ),
                confirmTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                selectionOverlay: Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: context.appColors.border!),
                    ),
                  ),
                ),
              ),
              dateFormat: 'HH:mm',
              onConfirm: (date, _) {
                context.read<WaterReminderBloc>().add(ChangeEndTimeEvent(date));
              },
            );
          },
          validator: (value) => value.isNullOrEmpty //
              ? 'Este campo es obligatorio'
              : null,
        );
      },
    );
  }
}
