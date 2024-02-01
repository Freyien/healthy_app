import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class WaterButton extends StatelessWidget {
  const WaterButton({
    super.key,
    required this.width,
    required this.onPressed,
    required this.imageName,
    required this.text,
  });

  final double width;
  final void Function() onPressed;
  final String imageName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          'assets/images/$imageName.png',
          height: 25,
        ),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(double.infinity, 55),
          elevation: 0,
          backgroundColor: context.appColors.water!,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          // side: BorderSide(
          //   width: 1.0,
          //   color: Colors.blue[200]!,
          // ),
        ),
      ),
    );
  }
}
