import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class HealthyBadge extends StatelessWidget {
  const HealthyBadge({
    super.key,
    required this.child,
    this.show = true,
  });

  final Widget child;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      key: UniqueKey(),
      showBadge: show,
      position: badges.BadgePosition.topStart(top: -3, start: -3),
      badgeStyle: badges.BadgeStyle(
        padding: EdgeInsets.all(6),
      ),
      badgeAnimation: badges.BadgeAnimation.slide(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: true,
        curve: Curves.bounceOut,
        colorChangeAnimationCurve: Curves.easeInCubic,
        slideTransitionPositionTween: badges.SlideTween(
          begin: Offset(0, -0.9),
          end: Offset(0, 0.0),
        ),
      ),
      child: child,
    );
  }
}
