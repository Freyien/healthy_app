import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class ModalBottomUtils {
  static Future<void> show(
    BuildContext context,
    Widget Function(BuildContext) builder,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appColors.navigationBar,
      elevation: 0,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: builder,
    );
  }
}
