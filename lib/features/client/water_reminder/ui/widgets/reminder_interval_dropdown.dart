import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/water_reminder/ui/bloc/water_reminder_bloc.dart';

class ReminderIntervalDropdown extends StatelessWidget {
  const ReminderIntervalDropdown(
      {super.key, required this.enable, required this.value});

  final bool enable;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Dropdown<int>(
      value: value,
      onChanged: (value) {
        context.read<WaterReminderBloc>().add(ChangeIntervalEvent(value!));
      },
      enabled: enable,
      hintText: 'Intervalo',
      prefixIcon: Icon(Icons.timer_outlined),
      items: [
        if (!kReleaseMode)
          DropdownMenuItem(
            value: 1,
            child: Text('1 minuto'),
          ),
        DropdownMenuItem(
          value: 30,
          child: Text('30 minutos'),
        ),
        DropdownMenuItem(
          value: 60,
          child: Text('1 hora'),
        ),
        DropdownMenuItem(
          value: 90,
          child: Text('1 hora 30 minutos'),
        ),
        DropdownMenuItem(
          value: 120,
          child: Text('2 horas'),
        ),
      ],
      validator: (value) {
        return value == null ? 'Este campo es obligatorio' : null;
      },
    );
  }
}
