import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/water_reminder/ui/bloc/water_reminder_bloc.dart';

class ReminderEnableSwitch extends StatelessWidget {
  const ReminderEnableSwitch({super.key, required this.enable});

  final bool enable;

  @override
  Widget build(BuildContext context) {
    bool _enable = enable;

    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return SwitchListTile.adaptive(
          value: _enable,
          onChanged: (value) {
            setState(() => _enable = value);
            context.read<WaterReminderBloc>().add(ChangeEnableEvent(value));
          },
          title: Text(
            'Activar recordatorios',
            style: TextStyle(
              color: context.appColors.textContrast,
            ),
          ),
          tileColor: context.appColors.input,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          secondary: Icon(
            Icons.notifications_active_outlined,
            color: context.appColors.primaryText,
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          contentPadding: EdgeInsets.only(right: 8, left: 16),
          activeColor: context.appColors.primary,
          inactiveTrackColor: context.appColors.scaffold,
        );
      },
    );
  }
}
