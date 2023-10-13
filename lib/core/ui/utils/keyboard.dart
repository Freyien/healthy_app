import 'package:flutter/material.dart';

class Keyboard {
  static void close(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
