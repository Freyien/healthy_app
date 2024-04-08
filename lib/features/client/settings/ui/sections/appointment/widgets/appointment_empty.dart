import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:lottie/lottie.dart';

class AppointmentEmpty extends StatelessWidget {
  const AppointmentEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: double.infinity),
          Lottie.asset(
            'assets/animations/appointment.json',
          ),
          VerticalSpace.large(),
          Text(
            'Aún no tienes una cita',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.appColors.textContrast,
              letterSpacing: -.5,
            ),
          ),
          VerticalSpace.small(),

          // Subtitle
          Text(
            'Acércate con tu nutriólogo/a para agendar una cita',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.grey,
                ),
          ),
          VerticalSpace.custom(40),
        ],
      ),
    );
  }
}
