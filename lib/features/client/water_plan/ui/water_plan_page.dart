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
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_plan_buttons.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_plan_header.dart';

class WaterPlanPage extends StatelessWidget {
  const WaterPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<WaterPlanBloc>()..add(GetWaterPlanEvent(DateTime.now())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('24 Octubre 2023'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.calendar_month_outlined),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          return SafeArea(
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                final bloc = context.read<WaterPlanBloc>();
                bloc.add(GetWaterPlanEvent(bloc.state.date));
              },
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
                child: BlocBuilder<WaterPlanBloc, WaterPlanState>(
                  builder: (context, state) {
                    // Initial
                    if (state.fetchingStatus == FetchingStatus.initial)
                      return WaterLoading();

                    // Loading
                    if (state.fetchingStatus == FetchingStatus.loading)
                      return WaterLoading();

                    // Failure
                    if (state.fetchingStatus == FetchingStatus.failure)
                      return ErrorFullScreen(onRetry: () {
                        final bloc = context.read<WaterPlanBloc>();
                        bloc.add(GetWaterPlanEvent(bloc.state.date));
                      });

                    if (state.waterPlan.id.isEmpty)
                      return MessageFullScreen(
                        widthPercent: .4,
                        animationName: 'empty',
                        title: 'No hay plan disponible',
                        subtitle:
                            'No tienes un plan alimenticio para este día, selecciona otro o acércate con tu nutriólogo/a',
                      );

                    // Success
                    return Stack(
                      children: [
                        // Positioned(
                        //   top: 0,
                        //   left: 0,
                        //   right: 0,
                        //   child: LottieBuilder.asset(
                        //     'assets/animations/confetti.json',
                        //   ),
                        // ),

                        CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header
                                    WaterPlanHeader(waterPlan: state.waterPlan),
                                    VerticalSpace.xxxlarge(),

                                    // Water container
                                    WaterContainer(waterPlan: state.waterPlan),
                                    VerticalSpace.xxxlarge(),
                                    VerticalSpace.large(),

                                    // Buttons
                                    WaterPlanButtons(),
                                    VerticalSpace.xxxlarge(),
                                    VerticalSpace.large(),

                                    // Water consumption title
                                    WaterConsumptionTitle(),
                                    VerticalSpace.small(),
                                  ],
                                ),
                              ),
                            ),

                            // Water consumption list
                            WaterConsumptionList(
                              waterConsumptionList:
                                  state.waterPlan.waterConsumptionList,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
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
