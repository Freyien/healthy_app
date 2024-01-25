import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';
import 'package:healthy_app/features/client/eating_plan/ui/widgets/date_time_line.dart';
import 'package:healthy_app/features/client/eating_plan/ui/widgets/eating_plan_appbar.dart';
import 'package:healthy_app/features/client/eating_plan/ui/widgets/eating_plan_loading.dart';
import 'package:healthy_app/features/client/eating_plan/ui/widgets/food_option_pagination.dart';
import 'package:healthy_app/features/client/eating_plan/ui/widgets/plan_block_title.dart';

class EatingPlanPage extends StatelessWidget {
  const EatingPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<EatingPlanBloc>()..add(GetEatingPlanEvent(DateTime.now())),
      child: Builder(builder: (context) {
        return Scaffold(
          body: RefreshIndicator.adaptive(
            onRefresh: () async {
              final bloc = context.read<EatingPlanBloc>();
              bloc.add(GetEatingPlanEvent(bloc.state.date));
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: context.appColors.scaffold,
                  toolbarHeight: 120,
                  leadingWidth: 0,
                  titleSpacing: 0,
                  pinned: false,
                  snap: false,
                  floating: true,
                  forceElevated: true,
                  title: Column(
                    children: [
                      EatingPlanAppBarTitle(),

                      // Date time line
                      DateTimeLine(),
                    ],
                  ),
                ),

                // Fetching builder
                BlocBuilder<EatingPlanBloc, EatingPlanState>(
                  buildWhen: (p, c) => p.fetchingStatus != c.fetchingStatus,
                  builder: (context, state) {
                    // Initial
                    if (state.fetchingStatus == FetchingStatus.initial)
                      return SliverToBoxAdapter(child: EatingPlanLoading());

                    // Loading
                    if (state.fetchingStatus == FetchingStatus.loading)
                      return SliverToBoxAdapter(child: EatingPlanLoading());

                    // Failure
                    if (state.fetchingStatus == FetchingStatus.failure)
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ErrorFullScreen(onRetry: () {
                            final bloc = context.read<EatingPlanBloc>();
                            bloc.add(GetEatingPlanEvent(bloc.state.date));
                          }),
                        ),
                      );

                    // Empty
                    if (state.eatingPlan.planBlockList.isEmpty)
                      return SliverFillRemaining(
                          child: MessageFullScreen(
                        widthPercent: .4,
                        animationName: 'empty',
                        title: 'No hay plan disponible',
                        subtitle:
                            'No tienes un plan alimenticio para este día, selecciona otro o acércate con tu nutriólogo/a',
                      ));

                    return SliverPadding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int planBlockIndex) {
                            final planBlock =
                                state.eatingPlan.planBlockList[planBlockIndex];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Plan block title
                                PlanBlockTitle(planBlock: planBlock),

                                // Divider
                                const HorizontalDivider(height: 0),
                                VerticalSpace.small(),

                                // Food option list
                                Column(
                                  children: List.generate(
                                      planBlock.foodBlockList.length, (index) {
                                    final foodBlock =
                                        planBlock.foodBlockList[index];

                                    // Food patination
                                    return FoodOptionPagination(
                                        foodBlock: foodBlock);
                                  }),
                                ),
                                VerticalSpace.xxlarge(),
                              ],
                            );
                          },
                          childCount: state.eatingPlan.planBlockList.length,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
