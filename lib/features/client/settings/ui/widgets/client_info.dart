import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/settings/ui/bloc/settings_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ClientInfo extends StatelessWidget {
  const ClientInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (p, c) => p.clientStatus != c.clientStatus,
      builder: (context, state) {
        // Intial
        if (state.clientStatus == FetchingStatus.initial) //
          return _Loading();

        // Loading
        if (state.clientStatus == FetchingStatus.loading) //
          return _Loading();

        // Failure
        if (state.clientStatus == FetchingStatus.failure)
          return SizedBox.shrink();

        // Success
        return Column(
          children: [
            Text(
              state.client.fullName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              state.client.email,
              style: TextStyle(
                fontSize: 12,
                color: context.appColors.textContrast!.withOpacity(.7),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Shimmer.fromColors(
          child: Container(
            height: 16,
            width: width * .6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
          ),
          baseColor: context.appColors.loadingBase!.withOpacity(.5),
          highlightColor: context.appColors.loadingHighlight!.withOpacity(.5),
        ),
        VerticalSpace.small(),
        Shimmer.fromColors(
          child: Container(
            height: 12,
            width: width * .4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
          ),
          baseColor: context.appColors.loadingBase!.withOpacity(.5),
          highlightColor: context.appColors.loadingHighlight!.withOpacity(.5),
        ),
      ],
    );
  }
}
