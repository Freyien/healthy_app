import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaterLoading extends StatelessWidget {
  const WaterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          // Info cards
          Row(children: [
            _InfoCard(),
            _InfoCard(),
          ]),
          VerticalSpace.large(),

          // Water container
          _WaterContainer(),
          VerticalSpace.xxxlarge(),
          VerticalSpace.large(),

          // Buttons
          _Buttons(),
          VerticalSpace.xxlarge(),

          // Title
          _Title(),
          VerticalSpace.small(),

          // Water items
          _WaterItems(),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: context.appColors.loadingBackground,
        child: Shimmer.fromColors(
          baseColor: context.appColors.loadingBase!,
          highlightColor: context.appColors.loadingHighlight!,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: 25,
                  width: double.infinity,
                  color: Colors.white,
                ),
                VerticalSpace.small(),
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WaterContainer extends StatelessWidget {
  const _WaterContainer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.appColors.loadingBackground!,
      highlightColor: context.appColors.loadingBackground!,
      child: Align(
        child: Container(
          height: 270,
          width: 270,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue,
            ),
          ),
          child: ClipOval(
            child: WaveWidget(
              config: CustomConfig(
                colors: [
                  Colors.white.withOpacity(.5),
                  Colors.white.withOpacity(.9),
                ],
                durations: [
                  5000,
                  4000,
                ],
                heightPercentages: [
                  0.01,
                  0.02,
                ],
              ),
              backgroundColor: Colors.blueGrey.withOpacity(.2),
              size: Size(double.infinity, double.infinity),
            ),
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runSpacing: 16,
          spacing: 16,
          children: List.generate(
            4,
            (index) => SizedBox(
              width: constraints.maxWidth * .5 - 8,
              child: ElevatedButton(
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.appColors.loadingBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.zero,
      child: Shimmer.fromColors(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 20,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        baseColor: context.appColors.loadingBase!,
        highlightColor: context.appColors.loadingHighlight!,
      ),
    );
  }
}

class _WaterItems extends StatelessWidget {
  const _WaterItems();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => Card(
          color: context.appColors.loadingBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 0),
          child: Shimmer.fromColors(
            baseColor: context.appColors.loadingBase!,
            highlightColor: context.appColors.loadingHighlight!,
            child: ListTile(
              leading: Container(
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
              trailing: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              shape: Border(
                bottom: BorderSide(
                  color: context.appColors.border!.withOpacity(.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
