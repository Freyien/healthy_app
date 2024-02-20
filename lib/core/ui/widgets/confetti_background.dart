import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfettiBackground extends StatelessWidget {
  const ConfettiBackground({
    super.key,
    required this.showConfetti,
    required this.opacity,
    required this.delay,
  });

  final bool showConfetti;
  final double opacity;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    if (!showConfetti) return SizedBox.shrink();

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: FadeIn(
        delay: delay,
        child: Opacity(
          opacity: opacity,
          child: Column(
            children: List.generate(
              3,
              (index) => LottieBuilder.asset(
                'assets/animations/confetti.json',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
