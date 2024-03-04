import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/entities/initial_route_entity.dart';
import 'package:healthy_app/core/domain/utils/router_utils.dart';
import 'package:healthy_app/features/client/dashboard/ui/dashboard_page.dart';
import 'package:healthy_app/features/client/delete_account/ui/delete_account_page.dart';
import 'package:healthy_app/features/client/doctor_code/ui/doctor_code_page.dart';
import 'package:healthy_app/features/client/eating_plan/ui/eating_plan_page.dart';
import 'package:healthy_app/features/client/initial_config/ui/initial_config_page.dart';
import 'package:healthy_app/features/client/measures_chart/ui/measures_chart_page.dart';
import 'package:healthy_app/features/client/personal_info/ui/personal_info_page.dart';
import 'package:healthy_app/features/client/settings/ui/settings_page.dart';
import 'package:healthy_app/features/client/sign_in/ui/sign_in_page.dart';
import 'package:healthy_app/features/client/sign_up/ui/sign_up_page.dart';
import 'package:healthy_app/features/client/suggestion/ui/suggestion_page.dart';
import 'package:healthy_app/features/client/verify_email/ui/verify_email_page.dart';
import 'package:healthy_app/features/client/water_plan/ui/water_plan_page.dart';
import 'package:healthy_app/features/client/water_reminder/ui/water_reminder_page.dart';
import 'package:healthy_app/features/client/water_success/ui/water_success_page.dart';
import 'package:healthy_app/features/common/app_update/domain/entities/app_version_status.dart';
import 'package:healthy_app/features/common/app_update/ui/app_update_page.dart';
import 'package:healthy_app/features/common/notifications/ui/notifications_page.dart';

class AppRouter {
  static GoRouter router(InitialRouteEntity initialRoute) {
    final initialLocation = RouterUtils.getLocation(initialRoute.name);

    final router = GoRouter(
      initialLocation: initialLocation,
      initialExtra: initialRoute.params,
      observers: [
        BotToastNavigatorObserver(),
      ],
      routes: [
        GoRoute(
          name: 'notification_request',
          path: '/notification_request',
          builder: (context, state) {
            return NotificationsPage();
          },
        ),
        GoRoute(
          name: 'sign_in',
          path: '/sign_in',
          builder: (context, state) {
            return SignInPage();
          },
        ),
        GoRoute(
          name: 'sign_up',
          path: '/sign_up',
          builder: (context, state) {
            return SignUpPage();
          },
        ),
        GoRoute(
          name: 'app_update',
          path: '/app_update',
          builder: (context, state) {
            final extra = (state.extra ?? {}) as Map<String, dynamic>;
            final appVersionStatus =
                extra['appVersionStatus'] as AppVersionStatus;

            return AppUpdatePage(
              appVersionStatus: appVersionStatus,
            );
          },
        ),
        GoRoute(
          name: 'initial_config',
          path: '/initial_config',
          builder: (context, state) {
            return InitialConfigPage();
          },
        ),
        GoRoute(
          name: 'personal_info',
          path: '/personal_info',
          builder: (context, state) {
            return PersonalInfoPage();
          },
        ),
        GoRoute(
          name: 'verify_email',
          path: '/verify_email',
          builder: (context, state) {
            return VerifyEmailPage();
          },
        ),
        GoRoute(
          name: 'doctor_code',
          path: '/doctor_code',
          builder: (context, state) {
            return DoctorCodePage();
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return DashboardPage(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'home',
                  path: '/home',
                  builder: (context, state) {
                    return EatingPlanPage();
                  },
                  routes: [
                    GoRoute(
                      name: 'eating_success',
                      path: 'eating_success',
                      builder: (context, state) {
                        final extra = json.decode(state.extra as String);
                        final milliseconds = extra['date'] as int;

                        return WaterSuccessPage(
                          date: DateTime.fromMillisecondsSinceEpoch(
                            milliseconds,
                          ),
                          imageName: extra['imageName'],
                          message: extra['message'],
                          subtitle: extra['subtitle'],
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'water_plan',
                  path: '/water_plan',
                  builder: (context, state) {
                    return WaterPlanPage();
                  },
                  routes: [
                    GoRoute(
                      name: 'water_success',
                      path: 'water_success',
                      builder: (context, state) {
                        final extra = json.decode(state.extra as String);
                        final milliseconds = extra['date'] as int;

                        return WaterSuccessPage(
                          date: DateTime.fromMillisecondsSinceEpoch(
                            milliseconds,
                          ),
                          imageName: extra['imageName'],
                          message: extra['message'],
                          subtitle: extra['subtitle'],
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'measures_chart',
                  path: '/measures_chart',
                  builder: (context, state) {
                    return MeasuresChartPage();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'settings',
                  path: '/settings',
                  builder: (context, state) {
                    return Settingspage();
                  },
                  routes: [
                    GoRoute(
                      name: 'suggestion',
                      path: 'suggestion',
                      builder: (context, state) {
                        return SuggestionPage();
                      },
                    ),
                    GoRoute(
                      name: 'water_reminder',
                      path: 'water_reminder',
                      builder: (context, state) {
                        return WaterReminderPage();
                      },
                    ),
                    GoRoute(
                      name: 'delete_account',
                      path: 'delete_account',
                      builder: (context, state) {
                        return DeleteAccountPage();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );

    return router;
  }
}
