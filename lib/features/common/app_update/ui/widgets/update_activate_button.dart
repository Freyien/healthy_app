import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:healthy_app/features/common/app_update/domain/entities/app_version_status.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, required this.appVersionStatus});

  final AppVersionStatus appVersionStatus;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: 'Actualizar',
      onPressed: () async {
        context.read<AnalyticsBloc>().add(LogEvent('updateButtonPressed'));

        String storeLink = '';
        if (Platform.isIOS)
          storeLink = appVersionStatus.iosStoreLink;
        else
          storeLink = appVersionStatus.androidStoreLink;

        final uri = Uri.parse(storeLink);
        if (await canLaunchUrl(uri)) {
          launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          print('Abre la tienda y actualiza de forma manual');
        }
      },
    );
  }
}
