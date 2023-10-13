import 'package:flutter/widgets.dart';

class HorizontalSpace {
  /// width: 2
  static Widget xxsmall() => const SizedBox(width: 2);

  /// width: 4
  static Widget xsmall() => const SizedBox(width: 4);

  /// width: 8
  static Widget small() => const SizedBox(width: 8);

  /// width: 12
  static Widget medium() => const SizedBox(width: 12);

  /// width: 16
  static Widget large() => const SizedBox(width: 16);

  /// width: 20
  static Widget xlarge() => const SizedBox(width: 20);

  /// width: 24
  static Widget xxlarge() => const SizedBox(width: 24);

  /// width: 28
  static Widget xxxlarge() => const SizedBox(width: 28);

  /// width: custom
  static Widget custom(double width) => SizedBox(width: width);
}
