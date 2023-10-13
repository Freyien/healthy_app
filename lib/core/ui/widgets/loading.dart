import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.animationName = 'circle_loading',
  });

  final String animationName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: Lottie.asset(
            'assets/animations/$animationName.json',
            width: constraints.maxWidth * .7,
          ),
        );
      },
    );
  }
}
