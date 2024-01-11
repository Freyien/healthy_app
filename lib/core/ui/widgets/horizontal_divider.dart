import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
      height: height,
    );
  }
}
