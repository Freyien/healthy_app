import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/water_plan/ui/bloc/water_plan_bloc.dart';
import 'package:healthy_app/features/client/water_plan/ui/widgets/water_button.dart';
import 'package:healthy_app/features/common/analytics/ui/bloc/analytics_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class WaterPlanButtons extends StatelessWidget {
  const WaterPlanButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final buttonWidth = constraints.maxWidth * .5 - 8;

        return Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          runSpacing: 16,
          spacing: 16,
          children: [
            WaterButton(
              width: buttonWidth,
              onPressed: () => _addWaterConsumption(context, 250),
              imageName: 'vaso',
              text: '250 ml',
            ),
            WaterButton(
              width: buttonWidth,
              onPressed: () => _addWaterConsumption(context, 500),
              imageName: 'agua',
              text: '500 ml',
            ),
            WaterButton(
              width: buttonWidth,
              onPressed: () => _addWaterConsumption(context, 600),
              imageName: 'agua',
              text: '600 ml',
            ),
            WaterButton(
              width: buttonWidth,
              onPressed: () => _showDialog(context),
              imageName: 'gota-de-agua',
              text: 'otro',
            ),
          ],
        );
      },
    );
  }

  void _addWaterConsumption(BuildContext context, int quantity) {
    context
        .read<AnalyticsBloc>()
        .add(LogEvent('addWaterConsumption', parameters: {
          'quantity': quantity,
        }));
    context.read<WaterPlanBloc>().add(AddWaterConsumptionEvent(quantity));
  }

  void _showDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: context.appColors.navigationBar,
        elevation: 0,
        isDismissible: true,
        builder: (contextModal) {
          return _Dialog(
            onPressed: (quantity) => _addWaterConsumption(context, quantity),
          );
        });
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({required this.onPressed});

  final Function(int quantity) onPressed;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final mask = MaskTextInputFormatter(
      mask: '####',
      filter: {"#": RegExp(r'^[\.0-9]*$')},
    );

    return PaddingFormColumn(
      mainAxisSize: MainAxisSize.min,
      formKey: formKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.all(0),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.4),
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, size: 20),
                padding: EdgeInsetsDirectional.all(0),
              ),
            ),
            Spacer(flex: 3),
            Text(
              'Personalizado',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            Spacer(flex: 4),
          ],
        ),
        VerticalSpace.xlarge(),
        InputText(
          labelText: 'Agua',
          hintText: 'Cantidad de agua',
          inputFormatters: [mask],
          autofocus: true,
          keyboardType: TextInputType.number,
          fillColor: context.appColors.water!.withOpacity(.4),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/gota-de-agua.png',
              width: 24,
              height: 24,
            ),
          ),
          suffixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'mls',
                style: TextStyle(
                  color: context.appColors.textContrast,
                ),
              ),
            ],
          ),
          validator: (val) {
            final value = val ?? '';
            if (value.isEmpty) return 'Este campo es obligatorio';

            if (value == '0') return 'Este campo debe ser mayor a 0';

            return null;
          },
        ),
        Text(
          '*Ingresa la cantidad en mililitros',
          style: TextStyle(
            color: context.appColors.textContrast,
          ),
        ),
        VerticalSpace.xlarge(),
        PrimaryButton(
          text: 'Aceptar',
          onPressed: () {
            if (!formKey.currentState!.validate()) return;

            final quantity = int.tryParse(mask.getUnmaskedText()) ?? 0;

            onPressed(quantity);

            Navigator.pop(context);
          },
        ),
        VerticalSpace.large(),
      ],
    );
  }
}
