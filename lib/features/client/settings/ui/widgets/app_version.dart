import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/client/settings/ui/bloc/settings_bloc.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (p, c) => p.versionStatus != c.versionStatus,
      builder: (context, state) {
        // Loading
        if (state.versionStatus == FetchingStatus.loading ||
            state.versionStatus == FetchingStatus.initial) {
          return SizedBox(
            width: double.infinity,
            child: Text(
              'Versión -.-.-',
              textAlign: TextAlign.end,
              style: TextStyle(color: context.appColors.textContrast),
            ),
          );
        }

        // Success
        if (state.versionStatus == FetchingStatus.success) {
          return SizedBox(
            width: double.infinity,
            child: Text(
              'Versión ${state.appVersion}',
              textAlign: TextAlign.end,
              style: TextStyle(color: context.appColors.textContrast),
            ),
          );
        }

        // Failure
        if (state.versionStatus == FetchingStatus.failure) {
          return SizedBox(
            width: double.infinity,
            child: Text(
              'Versión E-.-.-',
              textAlign: TextAlign.end,
              style: TextStyle(color: context.appColors.textContrast),
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
