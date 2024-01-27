import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/utils/keyboard.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/water_reminder/ui/bloc/water_reminder_bloc.dart';

class ReminderSaveButton extends StatelessWidget {
  const ReminderSaveButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: 30,
      delay: Duration(milliseconds: 100),
      child: PrimaryButton(
        text: 'Guardar',
        onPressed: () {
          Keyboard.close(context);
          if (!formKey.currentState!.validate()) return;

          context.read<WaterReminderBloc>().add(SaveEvent());
        },
      ),
    );
  }
}
