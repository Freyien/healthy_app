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
import 'package:healthy_app/features/client/water_plan/ui/widgets/appbar/water_plan_calendar_button.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/appbar/water_plan_current_day.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/appbar/water_plan_trophy_button.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_consumption_list.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_consumption_title.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_container.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_loading.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_plan_buttons.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_plan_date_line.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_plan_header.dart';

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
          leading: WaterPlanTrophyButton(),
          title: WaterPlanCurrentDay(),
          actions: [
            WaterPlanCalendarButton(),
            HorizontalSpace.small(),
          ],
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
                          child: ErrorFullScreen(onRetry: () {
                            final bloc = context.read<WaterPlanBloc>();
                            bloc.add(GetWaterPlanEvent(bloc.state.date));
                          }),
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
                              // Confetti
                              Positioned.fill(
                                child: ConfettiBackground(
                                  showConfetti:
                                      waterPlan.remainingWaterConsumption == 0,
                                  delay: Duration(milliseconds: 850),
                                  opacity: .4,
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header
                                  WaterPlanHeader(waterPlan: waterPlan),
                                  VerticalSpace.large(),

                                  // Water container
                                  WaterContainer(waterPlan: waterPlan),
                                  VerticalSpace.xxlarge(),

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
                    buildWhen: (p, c) =>
                        c.deletingStatus == DeletingStatus.success ||
                        c.savingStatus == SavingStatus.success ||
                        p.fetchingStatus != c.fetchingStatus,
                    builder: (context, state) {
                      if (state.fetchingStatus != FetchingStatus.success)
                        return SliverToBoxAdapter(child: SizedBox.shrink());

                      if (state.waterPlan.id.isEmpty)
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
