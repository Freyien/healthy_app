import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class AppointmentNotes extends StatelessWidget {
  const AppointmentNotes({super.key, required this.notes});

  final String notes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notas:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: context.appColors.textContrast!.withOpacity(.7),
          ),
        ),
        if (notes.isNotEmpty)
          Text(
            '- $notes',
            style: TextStyle(
              color: context.appColors.textContrast!.withOpacity(.6),
            ),
          ),
        Text(
          '- Recuerda llegar 5 minutos antes de tu cita.',
          style: TextStyle(
            color: context.appColors.textContrast!.withOpacity(.6),
          ),
        ),
      ],
    );
  }
}
