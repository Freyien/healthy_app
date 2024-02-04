import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/lottie.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/suggestion/domain/failures/suggestion_failure.dart';
import 'package:healthy_app/features/client/suggestion/ui/bloc/suggestion_bloc.dart';
import 'package:healthy_app/features/client/suggestion/ui/widgets/suggestion_form.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/ui/widgets/core_widgets.dart';

class SuggestionPage extends StatelessWidget {
  const SuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return BlocProvider(
      create: (context) => sl<SuggestionBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sugerencias'),
        ),
        body: BlocConsumer<SuggestionBloc, SuggestionState>(
          listener: _suggestionListener,
          listenWhen: (p, c) => c.status != p.status,
          buildWhen: (_, c) => c.status == SuggestionStatus.success,
          builder: (context, state) {
            if (state.status == SuggestionStatus.success) {
              return LayoutBuilder(builder: (context, constraints) {
                final size = constraints.maxWidth * .7;
                return ScrollFillRemaining(
                  child: Column(
                    children: [
                      Spacer(),
                      Lottie.asset(
                        'assets/animations/check.lottie',
                        decoder: LottieUtils.decoder,
                        fit: BoxFit.contain,
                        height: size,
                        width: size,
                        repeat: false,
                      ),
                      VerticalSpace.large(),
                      FadeInDown(
                        from: 30,
                        delay: Duration(seconds: 2),
                        child: Column(
                          children: [
                            Text(
                              '¡Gracias!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: appColors.textContrast,
                              ),
                            ),
                            VerticalSpace.small(),
                            Text(
                              'Agradecemos te hayas tomado el tiempo para darnos una sugerencia, la tomaremos en cuenta para mejorar nuestro servicio.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: appColors.textContrast!.withOpacity(.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                );
              });
            }

            return ScrollFillRemaining(
              child: Column(
                children: [
                  Text(
                    'Tomará un poco de tiempo, pero ten por seguro que leeremos cada sugerencia que envíes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: appColors.textContrast,
                    ),
                  ),
                  VerticalSpace.large(),
                  Expanded(
                    child: SuggestionForm(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _suggestionListener(BuildContext context, SuggestionState state) async {
    if (state.status == SuggestionStatus.loading) {
      return LoadingUtils.show(context);
    }

    await Future.delayed(Duration(seconds: 2));

    if (state.status == SuggestionStatus.success) {
      return LoadingUtils.hide(context);
    }

    if (state.status == SuggestionStatus.failure) {
      LoadingUtils.hide(context);

      if (state.failure is SuggestionLimitReachedFailure) {
        return Toast.showError('Solo puedes agregar 2 sugerencias por día.');
      }

      return Toast.showError('Ha ocurrido un error inesperado');
    }
  }
}
