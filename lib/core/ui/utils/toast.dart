import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Toast {
  static void showError(String message) {
    _showToast(const Key('errorToast'), message, Colors.red);
  }

  static void showSuccess(String message) {
    _showToast(
      const Key('successToast'),
      message,
      Color(0xff95CCBB),
      align: Alignment.topCenter,
    );
  }

  static void _showToast(
    Key? key,
    String message,
    Color color, {
    Alignment align = Alignment.bottomCenter,
  }) {
    BotToast.showCustomNotification(
      align: align,
      duration: const Duration(milliseconds: 3500),
      toastBuilder: (cancel) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            key: key,
            width: double.infinity,
            child: Material(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: ListTile(
                // dense: true,
                title: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                // trailing: IconButton(
                //   icon: const Icon(Icons.close, color: Colors.white),
                //   onPressed: cancel,
                // ),
              ),
            ),
          ),
        );
      },
    );
  }
}
