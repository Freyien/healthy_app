import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = Colors.transparent,
  });

  final void Function() onPressed;
  final Widget icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Material(
        color: backgroundColor,
        shape: const CircleBorder(),
        child: IconButton(
          splashRadius: 20,
          onPressed: onPressed,
          icon: icon,
          iconSize: 20,
        ),
      ),
    );
  }
}
