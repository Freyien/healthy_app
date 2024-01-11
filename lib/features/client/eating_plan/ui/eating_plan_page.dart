import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/utils/calendar.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/eating_plan/ui/bloc/eating_plan_bloc.dart';
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
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                IconButton(
                  onPressed: () {
                    final bloc = context.read<EatingPlanBloc>();
                    final date = bloc.state.date;

                    bloc.add(GetEatingPlanEvent(date.subtract(Duration(
                      days: 1,
                    ))));
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                BlocBuilder<EatingPlanBloc, EatingPlanState>(
                  builder: (context, state) {
                    return Text(state.date.format('MMMMd'));
                  },
                ),
                IconButton(
                  onPressed: () {
                    final bloc = context.read<EatingPlanBloc>();
                    final date = bloc.state.date;

                    bloc.add(GetEatingPlanEvent(date.add(
                      Duration(days: 1),
                    )));
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
                Spacer(flex: 1),
                IconButton(
                  onPressed: () {
                    CalendarUtils.showCalendarDatePicker(
                      context,
                      minDate: DateTime(2024),
                      maxDate: DateTime.now().add(Duration(days: 60)),
                      onConfirm: (date) {
                        context
                            .read<EatingPlanBloc>()
                            .add(GetEatingPlanEvent(date));
                      },
                    );
                  },
                  icon: Icon(Icons.calendar_month_outlined),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<EatingPlanBloc, EatingPlanState>(
              builder: (context, state) {
                if (state.fetchingStatus == FetchingStatus.initial)
                  return EatingPlanLoading();

                if (state.fetchingStatus == FetchingStatus.loading)
                  return EatingPlanLoading();

                if (state.fetchingStatus == FetchingStatus.failure)
                  return ErrorFullScreen(onRetry: () {
                    context
                        .read<EatingPlanBloc>()
                        .add(GetEatingPlanEvent(DateTime.now()));
                  });

                if (state.eatingPlan.planBlockList.isEmpty)
                  return MessageFullScreen(
                    widthPercent: .4,
                    animationName: 'empty',
                    title: 'No hay plan disponible',
                    subtitle:
                        'No tienes un plan alimenticio para este día, selecciona otro o acércate con tu nutriólogo/a',
                  );

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: state.eatingPlan.planBlockList.length,
                  itemBuilder: (BuildContext context, int planBlockIndex) {
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: planBlock.foodBlockList.length,
                          itemBuilder: (context, index) {
                            final foodBlock = planBlock.foodBlockList[index];

                            // Food patination
                            return FoodOptionPagination(foodBlock: foodBlock);
                          },
                        ),
                        VerticalSpace.xxlarge(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
