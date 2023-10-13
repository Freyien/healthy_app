import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';

class DraggableScrollShet extends StatelessWidget {
  const DraggableScrollShet({
    super.key,
    required this.children,
    this.shadowOffset = const Offset(0, -3),
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
  });

  final List<Widget> children;
  final Offset shadowOffset;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return DraggableScrollableSheet(
      expand: true,
      maxChildSize: .64,
      initialChildSize: .3,
      minChildSize: .3,
      snap: true,
      snapSizes: [.3, .64],
      builder: (_, controller) {
        return Container(
          padding: padding,
          decoration: BoxDecoration(
            color: appColors.scaffold,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: appColors.shadow!,
                offset: shadowOffset,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 4,
                    width: 60,
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: appColors.borderBold,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
              VerticalSpace.medium(),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  // physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
