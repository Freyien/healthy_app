import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:shimmer/shimmer.dart';

class ReminderWaterLoading extends StatelessWidget {
  const ReminderWaterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Card(
            color: context.appColors.loadingBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Shimmer.fromColors(
              child: SwitchListTile.adaptive(
                value: false,
                dense: true,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (_) {},
                secondary: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                title: Container(
                  height: 13,
                  width: double.infinity,
                  color: Colors.white,
                ),
                subtitle: Container(
                  height: 8,
                  width: double.infinity,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.only(right: 8, left: 16),
              ),
              baseColor: context.appColors.loadingBase!,
              highlightColor: context.appColors.loadingHighlight!,
            ),
          ),
          VerticalSpace.xlarge(),
          ...List.generate(
            3,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return Card(
                    color: context.appColors.loadingBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Container(
                      height: 8,
                      width: constraints.maxWidth * .7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: context.appColors.loadingBackground,
                      ),
                    ),
                  );
                }),
                Card(
                  color: context.appColors.loadingBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Shimmer.fromColors(
                    child: ListTile(
                      dense: true,
                      leading: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      ),
                      trailing: index == 0
                          ? Icon(
                              Icons.keyboard_arrow_down,
                            )
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                    ),
                    baseColor: context.appColors.loadingBase!,
                    highlightColor: context.appColors.loadingHighlight!,
                  ),
                ),
                VerticalSpace.xlarge(),
              ],
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: Shimmer.fromColors(
              baseColor: context.appColors.loadingBase!,
              highlightColor: context.appColors.loadingHighlight!,
              child: Container(
                width: double.infinity,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.infinity, 55),
              backgroundColor: context.appColors.loadingBackground,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          VerticalSpace.xxxlarge(),
        ],
      ),
    );
  }
}
