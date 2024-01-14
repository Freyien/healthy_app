import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/water_plan/domain/entities/water_consumption_entity.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_tile.dart';
import 'package:lottie/lottie.dart';

class WaterConsumptionList extends StatelessWidget {
  const WaterConsumptionList({super.key, required this.waterConsumptionList});

  final List<WaterConsumptionEntity> waterConsumptionList;

  @override
  Widget build(BuildContext context) {
    if (waterConsumptionList.isEmpty) return _EmptyList();

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final waterConsumption = waterConsumptionList[index];

            return WaterTile(
              waterConsumption: waterConsumption,
            );
          },
          childCount: waterConsumptionList.length,
        ),
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              // Animation
              FadeInLeft(
                from: 30,
                child: Container(
                  // width: constraints.maxWidth * .7,
                  // height: constraints.maxWidth * .7,
                  child: FadeIn(
                    child: Lottie.asset(
                      'assets/animations/empty.json',
                      // width: constraints.maxWidth * .7,
                    ),
                  ),
                ),
              ),
              VerticalSpace.large(),

              // Title
              FadeInUp(
                from: 30,
                child: Text(
                  'Aún no tienes consumos de agua',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textContrast,
                    letterSpacing: -.5,
                  ),
                ),
              ),
              VerticalSpace.small(),

              // Subtitle
              FadeInUp(
                from: 30,
                child: Text(
                  'Bebe algo de agua y no olvides registrarlas',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),

              VerticalSpace.xxxlarge(),
            ],
          );
        }),
      ),
    );
  }
}
