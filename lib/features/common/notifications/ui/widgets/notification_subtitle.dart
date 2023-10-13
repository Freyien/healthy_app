import 'package:flutter/material.dart';

class NotificationSubtitle extends StatelessWidget {
  const NotificationSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        'Activa las notificaciones para estar informado de nuevas promociones y productos',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.grey,
            ));
  }
}
