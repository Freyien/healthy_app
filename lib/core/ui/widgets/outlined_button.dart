import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    this.leading,
    required this.onPressed,
    required this.text,
  });

  final Widget? leading;
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: context.appColors.primary,
      ),
      child: Row(
        children: [
          // Leading widget
          if (leading != null) leading!,

          Expanded(
            child: Center(
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }
}
