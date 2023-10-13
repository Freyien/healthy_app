import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/usecases/get_initial_route_usecase.dart';
import 'package:healthy_app/core/domain/utils/router_utils.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:healthy_app/features/common/app_update/domain/entities/app_version_status.dart';

class UpdateLaterButton extends StatelessWidget {
  const UpdateLaterButton({
    super.key,
    required this.appVersionStatus,
  });

  final AppVersionStatus appVersionStatus;

  @override
  Widget build(BuildContext context) {
    if (appVersionStatus.type != UpdateVersionType.optional)
      return SizedBox.shrink();

    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () async {
        context.read<AnalyticsBloc>().add(LogEvent('laterUpdateButtonPressed'));

        final route = await sl<GetInitialRouteUseCase>().call(
          checkUpdateVersion: false,
          checkNotifications: false,
        );

        final location = RouterUtils.getLocation(route.name);
        context.go(location);
      },
      child: Text('Más tarde'),
    );
  }
}
