import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/enums/deleting_status.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_consumption_list.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_consumption_title.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_container.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_loading.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_plan_appbar.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_plan_buttons.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_plan_date_line.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_plan_header.dart';
import 'package:lottie/lottie.dart';

class WaterPlanPage extends StatelessWidget {
  const WaterPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dateLineHeight = 76.0;

    return BlocProvider(
      create: (context) =>
          sl<WaterPlanBloc>()..add(GetWaterPlanEvent(DateTime.now())),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: WaterPlanAppBarTitle(),
        ),
        body: Builder(builder: (context) {
          return SafeArea(
            child: MultiBlocListener(
              listeners: [
                BlocListener<WaterPlanBloc, WaterPlanState>(
                  listenWhen: (p, c) => p.savingStatus != c.savingStatus,
                  listener: _savingListener,
                ),
                BlocListener<WaterPlanBloc, WaterPlanState>(
                  listenWhen: (p, c) => p.deletingStatus != c.deletingStatus,
                  listener: _deletingListener,
                ),
              ],
              child: CustomScrollView(
                slivers: [
                  // Appbar
                  SliverAppBar(
                    toolbarHeight: dateLineHeight,
                    leadingWidth: 0,
                    titleSpacing: 0,
                    pinned: false,
                    snap: true,
                    floating: true,
                    stretch: false,
                    title: WaterPlanDateLine(height: dateLineHeight),
                  ),

                  // Fetching builder
                  BlocBuilder<WaterPlanBloc, WaterPlanState>(
                    builder: (context, state) {
                      // Initial
                      if (state.fetchingStatus == FetchingStatus.initial)
                        return SliverToBoxAdapter(child: WaterLoading());

                      // Loading
                      if (state.fetchingStatus == FetchingStatus.loading)
                        return SliverToBoxAdapter(child: WaterLoading());

                      // Failure
                      if (state.fetchingStatus == FetchingStatus.failure)
                        return SliverFillRemaining(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: ErrorFullScreen(onRetry: () {
                              final bloc = context.read<WaterPlanBloc>();
                              bloc.add(GetWaterPlanEvent(bloc.state.date));
                            }),
                          ),
                        );

                      // Empty
                      if (state.waterPlan.id.isEmpty)
                        return SliverFillRemaining(
                          child: MessageFullScreen(
                            widthPercent: .4,
                            animationName: 'empty',
                            title: 'No hay plan disponible',
                            subtitle:
                                'No tienes un plan de hidratación para este día, selecciona otro o acércate con tu nutriólogo/a',
                          ),
                        );

                      // Success
                      final waterPlan = state.waterPlan;
                      return SliverPadding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        sliver: SliverToBoxAdapter(
                          child: Stack(
                            children: [
                              if (waterPlan.remainingWaterConsumption == 0)
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: FadeIn(
                                    duration: Duration(seconds: 1),
                                    child: LottieBuilder.asset(
                                      'assets/animations/confetti.json',
                                    ),
                                  ),
                                ),
                              if (waterPlan.remainingWaterConsumption == 0)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: FadeIn(
                                    duration: Duration(seconds: 1),
                                    child: LottieBuilder.asset(
                                      'assets/animations/confetti.json',
                                    ),
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header
                                  WaterPlanHeader(waterPlan: waterPlan),
                                  VerticalSpace.xxlarge(),

                                  // Water container
                                  WaterContainer(waterPlan: waterPlan),
                                  VerticalSpace.xxxlarge(),
                                  VerticalSpace.medium(),

                                  // Buttons
                                  WaterPlanButtons(),
                                  VerticalSpace.xxxlarge(),
                                  VerticalSpace.medium(),

                                  // Water consumption title
                                  WaterConsumptionTitle(),
                                  VerticalSpace.small(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  BlocBuilder<WaterPlanBloc, WaterPlanState>(
                    builder: (context, state) {
                      if (state.fetchingStatus != FetchingStatus.success)
                        return SliverToBoxAdapter(child: SizedBox.shrink());

                      return WaterConsumptionList(
                        waterConsumptionList:
                            state.waterPlan.waterConsumptionList,
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _savingListener(BuildContext context, WaterPlanState state) {
    switch (state.savingStatus) {
      case SavingStatus.initial:
        break;
      case SavingStatus.loading:
        LoadingUtils.show(context);
        break;
      case SavingStatus.failure:
        LoadingUtils.hide(context);
        return Toast.showError('Ha ocurrido un error inesperado.');
      case SavingStatus.success:
        return LoadingUtils.hide(context);
    }
  }

  void _deletingListener(BuildContext context, WaterPlanState state) {
    switch (state.deletingStatus) {
      case DeletingStatus.initial:
        break;
      case DeletingStatus.loading:
        LoadingUtils.show(context);
        break;
      case DeletingStatus.failure:
        LoadingUtils.hide(context);
        return Toast.showError('Ha ocurrido un error inesperado.');
      case DeletingStatus.success:
        return LoadingUtils.hide(context);
    }
  }
}
