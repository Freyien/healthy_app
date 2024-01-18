import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:lottie/lottie.dart';

class MessageFullScreen extends StatelessWidget {
  const MessageFullScreen({
    super.key,
    required this.animationName,
    this.widthPercent = .7,
    required this.title,
    required this.subtitle,
  });

  final String animationName;
  final double widthPercent;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ScrollFillRemaining(
          padding: EdgeInsetsDirectional.all(24),
          child: Column(
            children: [
              Spacer(),

              // Animation
              FadeInDown(
                from: 30,
                child: Container(
                  width: constraints.maxWidth * widthPercent,
                  height: constraints.maxWidth * widthPercent,
                  child: FadeIn(
                    child: Lottie.asset(
                      'assets/animations/$animationName.json',
                      width: constraints.maxWidth * widthPercent,
                    ),
                  ),
                ),
              ),
              VerticalSpace.large(),

              // Title
              FadeInUp(
                from: 30,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: appColors.textContrast,
                    letterSpacing: -.5,
                  ),
                ),
              ),
              VerticalSpace.small(),

              // Subtitle
              FadeInUp(
                from: 30,
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              Spacer(),
              VerticalSpace.medium(),
            ],
          ),
        );
      },
    );
  }
}
