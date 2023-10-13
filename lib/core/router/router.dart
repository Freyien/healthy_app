import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/entities/initial_route_entity.dart';
import 'package:healthy_app/core/domain/utils/router_utils.dart';
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
            return Scaffold();
          },
        ),
        GoRoute(
          name: 'sign_up',
          path: '/sign_up',
          builder: (context, state) {
            return Scaffold();
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
            return Scaffold();
            // return DashboardPage(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'home',
                  path: '/home',
                  builder: (context, state) {
                    return Scaffold();
                  },
                  routes: [],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: 'store_location',
                  path: '/store_location',
                  builder: (context, state) {
                    return Scaffold();
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
