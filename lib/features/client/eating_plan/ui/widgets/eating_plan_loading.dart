import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:shimmer/shimmer.dart';

class EatingPlanLoading extends StatelessWidget {
  const EatingPlanLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: List.generate(
            4,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace.small(),
                Card(
                  color: context.appColors.loadingBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 24, 8),
                    child: Shimmer.fromColors(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 20,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          HorizontalSpace.xlarge(),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      baseColor: context.appColors.loadingBase!.withOpacity(.5),
                      highlightColor:
                          context.appColors.loadingHighlight!.withOpacity(.5),
                    ),
                  ),
                ),
                VerticalSpace.small(),
                Column(
                  children: List.generate(
                    4,
                    (index) => _Loading(),
                  ),
                ),
                VerticalSpace.medium(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.appColors.loadingBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      elevation: 0,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Shimmer.fromColors(
        child: CheckboxListTile(
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
          shape: Border(
            bottom: BorderSide(
              color: context.appColors.border!.withOpacity(.5),
            ),
          ),
        ),
        baseColor: context.appColors.loadingBase!,
        highlightColor: context.appColors.loadingHighlight!,
      ),
    );
  }
}
