import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/entities/initial_route_entity.dart';
import 'package:healthy_app/core/domain/utils/router_utils.dart';
import 'package:healthy_app/features/client/dashboard/ui/dashboard_page.dart';
import 'package:healthy_app/features/client/doctor_code/ui/doctor_code_page.dart';
import 'package:healthy_app/features/client/eating_plan/ui/eating_plan_page.dart';
import 'package:healthy_app/features/client/sign_in/ui/sign_in_page.dart';
import 'package:healthy_app/features/client/sign_up/ui/sign_up_page.dart';
import 'package:healthy_app/features/client/water/ui/water_page.dart';
import 'package:healthy_app/features/common/app_update/domain/entities/app_version_status.dart';
import 'package:healthy_app/features/common/app_update/ui/app_update_page.dart';
import 'package:healthy_app/features/common/notifications/ui/notifications_page.dart';

class AppRouter {
  static GoRouter router(InitialRouteEntity initialRoute) {
    final initialLocation = RouterUtils.getLocation(initialRoute.name);

    final router = GoRouter(
      initialLocation: '/doctor_code',
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
          name: 'doctor_code',
          path: '/doctor_code',
          builder: (context, state) {
            return DoctorCodePage();
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
                  routes: [],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'water',
                  path: '/water',
                  builder: (context, state) {
                    return WaterPage();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'my_qr_code',
                  path: '/my_qr_code',
                  builder: (context, state) {
                    return Scaffold();
                  },
                )
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'offers',
                  path: '/offers',
                  builder: (context, state) {
                    return Scaffold();
                  },
                  routes: [],
                )
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'account',
                  path: '/account',
                  builder: (context, state) {
                    return Scaffold();
                  },
                  routes: [],
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
