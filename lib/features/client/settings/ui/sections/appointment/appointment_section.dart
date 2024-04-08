import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/modal_bottom.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/settings/domain/entities/appointment_entity.dart';
import 'package:healthy_app/features/client/settings/ui/sections/appointment/bloc/appointment_bloc.dart';
import 'package:healthy_app/features/client/settings/ui/sections/appointment/widgets/appointment_datetime.dart';
import 'package:healthy_app/features/client/settings/ui/sections/appointment/widgets/appointment_empty.dart';
import 'package:healthy_app/features/client/settings/ui/sections/appointment/widgets/appointment_notes.dart';
import 'package:healthy_app/features/client/settings/ui/sections/appointment/widgets/appointment_status_bar.dart';
import 'package:healthy_app/features/client/settings/ui/widgets/account_option.dart';

class AppointmentSection extends StatelessWidget {
  const AppointmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        // Failure
        if (state.fetchingStatus.isFailure) return SizedBox.shrink();

        // Get text status
        final textStatus = _getAppointmentStatus(state.appointment.status);
        final textDate = _getAppointmentDate(
          state.appointment.status,
          state.appointment.startTime,
        );

        final statusIspendingConfirmation =
            state.appointment.status == AppointmentStatus.pendingConfirmation;

        return AccountOption(
          icon: Icons.calendar_month_outlined,
          iconWidget: HealthyBadge(
            show: statusIspendingConfirmation,
            child: Icon(
              Icons.calendar_month_outlined,
              color: context.appColors.textContrast!.withOpacity(.7),
            ),
          ),
          title: textStatus,
          subtitle: textDate,
          onTap: () => openDialog(context),
        );
      },
    );
  }

  String _getAppointmentStatus(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.none:
        return 'No tienes una cita agendada';
      case AppointmentStatus.scheduled:
        return 'Tienes una cita';
      case AppointmentStatus.pendingConfirmation:
        return 'Confirma tu cita';
      case AppointmentStatus.confirmed:
        return 'Cita confirmada';
    }
  }

  String _getAppointmentDate(AppointmentStatus status, DateTime date) {
    if (status == AppointmentStatus.none) return 'Acércate con tu nutriólogo/a';

    final day = date.format('MMMMd');
    final time = date.format('h:mm a').replaceAll('.', '');

    return '$day - $time';
  }

  Future<void> openDialog(BuildContext context) async {
    await ModalBottomUtils.show(
      context,
      (contextModal) {
        return BlocBuilder<AppointmentBloc, AppointmentState>(
          builder: (context, state) {
            final textStatus = _getAppointmentStatus(state.appointment.status);

            // Empty appointment
            if (state.appointment.status == AppointmentStatus.none)
              return AppointmentEmpty();

            return _ModalContent(
              context,
              appointment: state.appointment,
              textStatus: textStatus,
            );
          },
        );
      },
    );
  }
}

class _ModalContent extends StatelessWidget {
  const _ModalContent(
    this.pageContext, {
    required this.appointment,
    required this.textStatus,
  });

  final BuildContext pageContext;
  final AppointmentEntity appointment;
  final String textStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Status bar
        AppointmentStatusBar(
          status: appointment.status,
          text: textStatus,
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpace.large(),

              // Datetime
              AppointmentDatetime(
                date: appointment.startTime,
              ),
              VerticalSpace.custom(64),

              // Notes
              AppointmentNotes(notes: appointment.notes),

              // Save button
              if (appointment.status == AppointmentStatus.pendingConfirmation)
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: PrimaryButton(
                    text: 'Confirmar cita',
                    onPressed: () {
                      Navigator.pop(context);

                      pageContext
                          .read<AppointmentBloc>()
                          .add(ConfirmAppointmentEvent());
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
