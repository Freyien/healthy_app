import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:lottie/lottie.dart';

class ErrorFullScreen extends StatelessWidget {
  const ErrorFullScreen({
    super.key,
    required this.onRetry,
  });

  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = width * .7;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Spacer(),
          Lottie.asset(
            'assets/animations/dog_error.json',
            fit: BoxFit.contain,
            height: size,
            width: size,
          ),
          Spacer(),
          VerticalSpace.large(),
          Column(
            children: [
              Text(
                '¡Ha sucedido un error inesperado!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textContrast,
                  letterSpacing: -.5,
                ),
              ),
              VerticalSpace.small(),
              Text(
                'El perrito que pusimos a cargo del mantenimiento está un poco cansado, deja que beba y coma algo e intenta de nuevo más tarde.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Spacer(),
          PrimaryButton(
            text: 'Reintentar',
            onPressed: onRetry,
          ),
          VerticalSpace.xxlarge(),
        ],
      ),
    );
  }
}
