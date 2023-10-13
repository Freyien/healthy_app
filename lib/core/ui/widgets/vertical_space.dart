import 'package:flutter/widgets.dart';

class VerticalSpace {
  /// height: 2
  static Widget xxsmall() => const SizedBox(height: 2);

  /// height: 4
  static Widget xsmall() => const SizedBox(height: 4);

  /// height: 8
  static Widget small() => const SizedBox(height: 8);

  /// height: 12
  static Widget medium() => const SizedBox(height: 12);

  /// height: 16
  static Widget large() => const SizedBox(height: 16);

  /// height: 20
  static Widget xlarge() => const SizedBox(height: 20);

  /// height: 24
  static Widget xxlarge() => const SizedBox(height: 24);

  /// height: 28
  static Widget xxxlarge() => const SizedBox(height: 28);

  /// height: custom
  static Widget custom(double height) => SizedBox(height: height);
}
