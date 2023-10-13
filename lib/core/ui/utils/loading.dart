import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoadingUtils {
  static void hide(BuildContext context) {
    context.loaderOverlay.hide();
  }

  static void show(BuildContext context) {
    context.loaderOverlay.show();
  }
}
