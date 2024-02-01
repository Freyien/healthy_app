import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/dashboard/ui/sections/notifications/dashboard_notification.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    context.read<AnalyticsBloc>().add(SetDefaultParametersEvent());

    return DashboardNotifications(
      navigationShell: navigationShell,
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: context.appColors.navigationBar,
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.utensils),
              label: "Alimentos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.water_drop),
              label: "Agua",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: "Medidas",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Configuración",
            ),
          ],
          currentIndex: navigationShell.currentIndex,
          onTap: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          selectedLabelStyle: TextStyle(
            color: appColors.primary,
            fontSize: 11,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
          ),
          unselectedItemColor: context.appColors.unselectedItemColor,
          fixedColor: navigationShell.currentIndex == 1
              ? context.appColors.water
              : context.appColors.primary,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
