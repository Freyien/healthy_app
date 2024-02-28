import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/entities/initial_route_entity.dart';
import 'package:healthy_app/core/router/router.dart';
import 'package:healthy_app/core/ui/theme/custom_theme.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:healthy_app/l10n/l10n.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  App({required InitialRouteEntity initialRoute}) {
    routerConfig = AppRouter.router(initialRoute);
  }

  late final RouterConfig<Object> routerConfig;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AnalyticsBloc>()
        ..add(
          SetDefaultParametersEvent(),
        ),
      child: Builder(builder: (context) {
        context.read<AnalyticsBloc>();

        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidgetBuilder: (_) => Loading(),
          overlayColor: Colors.black54,
          child: MaterialApp.router(
            theme: CustomTheme.dolceTheme,
            darkTheme: CustomTheme.dolceDarkTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: BotToastInit(),
            routerConfig: routerConfig,
          ),
        );
      }),
    );
  }
}
