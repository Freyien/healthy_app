import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class AccountOption extends StatelessWidget {
  const AccountOption({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.iconWidget,
    this.subtitle = '',
    this.showTrailing = true,
    this.showBorder = true,
  });

  final void Function() onTap;
  final IconData icon;
  final Widget? iconWidget;
  final String title;
  final String subtitle;
  final bool showTrailing;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    Widget? subtitleWidget;

    if (subtitle.isNotEmpty)
      subtitleWidget = Text(
        subtitle,
        style: TextStyle(color: appColors.textContrast),
      );

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        minLeadingWidth: 16,
        onTap: onTap,
        dense: true,
        leading: iconWidget ??
            Icon(
              icon,
              color: appColors.primaryText!.withOpacity(.7),
            ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: appColors.textContrast,
          ),
        ),
        subtitle: subtitleWidget,
        trailing: showTrailing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: appColors.primaryText!.withOpacity(.7),
                  ),
                ],
              )
            : null,
        tileColor: appColors.input,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
