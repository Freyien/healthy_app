import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/utils/keyboard.dart';

class ScrollFillRemaining extends StatelessWidget {
  const ScrollFillRemaining({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          Keyboard.close(context);
        },
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: padding ?? const EdgeInsets.all(16),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
