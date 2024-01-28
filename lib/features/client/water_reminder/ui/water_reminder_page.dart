import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/water_reminder/ui/bloc/water_reminder_bloc.dart';
import 'package:healthy_app/features/client/water_reminder/ui/widgets/reminder_enable_switch.dart';
import 'package:healthy_app/features/client/water_reminder/ui/widgets/reminder_end_input.dart';
import 'package:healthy_app/features/client/water_reminder/ui/widgets/reminder_interval_dropdown.dart';
import 'package:healthy_app/features/client/water_reminder/ui/widgets/reminder_save_button.dart';
import 'package:healthy_app/features/client/water_reminder/ui/widgets/reminder_start_input.dart';
import 'package:healthy_app/features/client/water_reminder/ui/widgets/reminder_water_loading.dart';
import 'package:healthy_app/features/client/water_reminder/ui/widgets/water_reminter_wave.dart';

class WaterReminderPage extends StatelessWidget {
  const WaterReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) =>
          sl<WaterReminderBloc>()..add(GetWaterReminderEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Recordatorios de agua'),
          actions: [
            IconButton(
              onPressed: () {
                showAdaptiveDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog.adaptive(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.all(16),
                      title: Text('¿Cómo funcionan los recordatorios?'),
                      content: SizedBox(
                        width: 800,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VerticalSpace.small(),
                            Text(
                              'Recibirás recordatorios ⏰ solo cuando no hayas registrado algún consumo de agua. 💧',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  // fontSize: 14,
                                  ),
                            ),
                            VerticalSpace.large(),
                            Text(
                              'Ejemplo: 🙏🏼',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  // fontSize: 14,
                                  ),
                            ),
                            Text(
                              '- Tienes un intervalo de 2 horas.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  // fontSize: 14,
                                  ),
                            ),
                            Text(
                              '- Tu primer recordatorio es a las 07:00.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  // fontSize: 14,
                                  ),
                            ),
                            Text(
                              '- El siguiente recordatorio lo tendrías a las 09:00. 💧',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  // fontSize: 14,
                                  ),
                            ),
                            VerticalSpace.large(),
                            Text(
                              'Si registras 🗒️ un consumo de agua a las 08:00, entonces el siguiente recordatorio será a las 10:00 y no a las 09:00. ❤️',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  // fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        AdaptiveAction(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text('Entendido'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.help_outline),
            ),
          ],
        ),
        body: BlocConsumer<WaterReminderBloc, WaterReminderState>(
          listenWhen: (p, c) => p.savingStatus != c.savingStatus,
          listener: _savingListener,
          buildWhen: (p, c) => p.fetchingStatus != c.fetchingStatus,
          builder: (context, state) {
            // Initial
            if (state.fetchingStatus == FetchingStatus.initial)
              return ReminderWaterLoading();

            // Loading
            if (state.fetchingStatus == FetchingStatus.loading)
              return ReminderWaterLoading();

            // Failure
            if (state.fetchingStatus == FetchingStatus.failure)
              return ErrorFullScreen(onRetry: () {
                final bloc = context.read<WaterReminderBloc>();
                bloc.add(GetWaterReminderEvent());
              });

            // Success
            return Stack(
              children: [
                // Wave
                WaterReminderWave(),

                // Form
                ScrollFillRemaining(
                  padding: EdgeInsets.zero,
                  child: PaddingFormColumn(
                    formKey: formKey,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Builder
                      BlocBuilder<WaterReminderBloc, WaterReminderState>(
                        buildWhen: (p, c) =>
                            p.waterReminder.enable != c.waterReminder.enable,
                        builder: (context, state) {
                          final enable = state.waterReminder.enable;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Enable switch
                              ReminderEnableSwitch(enable: enable),
                              VerticalSpace.xxxlarge(),

                              // Interval
                              Text(
                                  'Elige el intervalo para recibir recordatorios'),
                              ReminderIntervalDropdown(
                                enable: enable,
                                value: state.waterReminder.minuteInterval,
                              ),
                              VerticalSpace.xlarge(),

                              // Start
                              Text(
                                  'Elige la hora donde recibirás el primer recordatorio'),
                              ReminderStartInput(enable: enable),
                              VerticalSpace.xlarge(),

                              // End
                              Text(
                                  'Elige la hora límite para recibir recordatorios'),
                              ReminderEndInput(enable: enable),
                              VerticalSpace.xlarge(),
                            ],
                          );
                        },
                      ),

                      // Button
                      Spacer(),
                      ReminderSaveButton(formKey: formKey),
                      VerticalSpace.xxxlarge(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _savingListener(BuildContext context, WaterReminderState state) {
    switch (state.savingStatus) {
      case SavingStatus.initial:
        break;
      case SavingStatus.loading:
        LoadingUtils.show(context);
        break;
      case SavingStatus.failure:
        LoadingUtils.hide(context);
        return Toast.showError('Ha ocurrido un error inesperado.');
      case SavingStatus.success:
        return LoadingUtils.hide(context);
    }
  }
}
