import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/constants/healthy_constants.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';
import 'package:intl/intl.dart';

class TrophyButton extends StatefulWidget {
  const TrophyButton({super.key});

  @override
  State<TrophyButton> createState() => _TrophyButtonState();
}

class _TrophyButtonState extends State<TrophyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController? animateController;
  late bool? lastValue;

  @override
  void initState() {
    super.initState();
    animateController = null;
    lastValue = null;
  }

  @override
  void dispose() {
    animateController?.dispose();
    super.dispose();
  }

  void _animatebutton(bool show) async {
    if (animateController == null) return;
    if (lastValue == show) return;
    lastValue = show;

    if (!show) return;

    animateController?.stop();
    animateController?.reset();
    await Future.delayed(Duration(milliseconds: 1300));
    animateController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterPlanBloc, WaterPlanState>(
      builder: (context, state) {
        final remainingWaterConsumption =
            state.waterPlan.remainingWaterConsumption;

        final show = remainingWaterConsumption == 0;
        final height = show ? 71.0 : 0.0;

        _animatebutton(show);

        return AnimatedContainer(
          duration: Duration(milliseconds: 450),
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.only(bottom: 16),
          child: BounceInDown(
            from: 50,
            controller: (controller) {
              animateController = controller;
              _animatebutton(show);
            },
            manualTrigger: true,
            child: ElevatedButton.icon(
              onPressed: () => _goToWaterSuccess(context),
              icon: SvgPicture.asset(
                'assets/svg/trophies/trophy-8.svg',
                height: 25,
              ),
              label: Text('Ver logro'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: context.appColors.primary!,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _goToWaterSuccess(BuildContext context) {
    final state = context.read<WaterPlanBloc>().state;
    final date = state.date;
    final water = state.waterPlan.water / 1000;
    final dayOfWeek = int.parse(DateFormat('D').format(date));

    final message = HealthyConstants.waterSuccessMessageList[dayOfWeek - 1];
    final imageName = 'trophy-$dayOfWeek';
    final subtitle = '$water lts';

    context.goNamed('water_success', extra: {
      'date': date,
      'imageName': imageName,
      'message': message,
      'subtitle': subtitle,
    });
  }
}
