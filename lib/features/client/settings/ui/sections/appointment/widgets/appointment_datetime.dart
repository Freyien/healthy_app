import 'package:flutter/material.dart';
import 'package:healthy_app/core/extensions/datetime.dart';

class AppointmentDatetime extends StatelessWidget {
  const AppointmentDatetime({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            date.format('MMMMEEEEd'),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Center(
          child: Text(
            date.format('hh:mm'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              height: .9,
            ),
          ),
        ),
        Center(
          child: Text(
            date.format('a').toUpperCase().replaceAll('.', ''),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: .8,
              letterSpacing: -1,
            ),
          ),
        ),
      ],
    );
  }
}
