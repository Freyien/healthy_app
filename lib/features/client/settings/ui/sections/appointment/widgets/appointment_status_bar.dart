import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/settings/domain/entities/appointment_entity.dart';

class AppointmentStatusBar extends StatelessWidget {
  const AppointmentStatusBar({
    super.key,
    required this.text,
    required this.status,
  });

  final String text;
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final color = _getColor(context, status);

    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      width: double.infinity,
      margin: EdgeInsets.only(),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getColor(BuildContext context, AppointmentStatus status) {
    if (status == AppointmentStatus.pendingConfirmation)
      return Colors.grey[500]!;

    return context.appColors.primary!;
  }
}
