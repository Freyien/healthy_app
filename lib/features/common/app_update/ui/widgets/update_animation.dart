import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:lottie/lottie.dart';

class UpdateAnimation extends StatelessWidget {
  const UpdateAnimation({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.flashWhite!.withOpacity(.4),
        borderRadius: BorderRadius.circular(700),
      ),
      child: Lottie.asset(
        'assets/animations/rocket.json',
        width: width,
        height: width,
      ),
    );
  }
}
