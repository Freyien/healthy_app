import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/common/app_update/domain/entities/app_version_status.dart';
import 'package:healthy_app/features/common/app_update/ui/widgets/update_activate_button.dart';
import 'package:healthy_app/features/common/app_update/ui/widgets/update_animation.dart';
import 'package:healthy_app/features/common/app_update/ui/widgets/update_later_button.dart';
import 'package:healthy_app/features/common/app_update/ui/widgets/update_subtitle.dart';
import 'package:healthy_app/features/common/app_update/ui/widgets/update_title.dart';

class AppUpdatePage extends StatelessWidget {
  const AppUpdatePage({
    super.key,
    required this.appVersionStatus,
  });

  final AppVersionStatus appVersionStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ScrollFillRemaining(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Spacer(),
                  // Animation
                  UpdateAnimation(width: constraints.maxWidth * .7),
                  VerticalSpace.xxlarge(),

                  // Title
                  UpdateTitle(),
                  VerticalSpace.small(),

                  // Subtitle
                  UpdateSubtitle(),
                  Spacer(),
                  VerticalSpace.medium(),

                  // Activate Updates
                  UpdateButton(appVersionStatus: appVersionStatus),
                  VerticalSpace.medium(),

                  // Latter button
                  UpdateLaterButton(
                    appVersionStatus: appVersionStatus,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
