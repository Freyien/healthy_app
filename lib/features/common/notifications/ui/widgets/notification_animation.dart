import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:lottie/lottie.dart';

class NotificationAnimation extends StatelessWidget {
  const NotificationAnimation({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.flashWhite!.withOpacity(.4),
        borderRadius: BorderRadius.circular(700),
      ),
      child: Lottie.asset(
        'assets/animations/notification.json',
        width: width,
        height: width,
      ),
    );
  }
}
