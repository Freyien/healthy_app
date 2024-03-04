import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/personal_info/ui/bloc/personal_info_bloc.dart';

class BornDateInput extends StatelessWidget {
  const BornDateInput({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final now = DateTime.now();

    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      builder: (context, state) {
        final bornDate = state.personalInfo.bornDate;
        final initialDateTime = bornDate ?? now;
        final initialValue = bornDate?.formated() ?? '';

        return InputText(
          key: UniqueKey(),
          labelText: 'Fecha de nacimiento',
          prefixIcon: Icon(Icons.calendar_month),
          readOnly: true,
          hintText: '07 de enero de 1994',
          initialValue: initialValue,
          onTap: () {
            DatePicker.showDatePicker(
              context,
              locale: DateTimePickerLocale.es,
              initialDateTime: initialDateTime,
              minDateTime: DateTime(1900),
              maxDateTime: DateTime.now(),
              pickerTheme: DateTimePickerTheme(
                backgroundColor: appColors.scaffold!,
                itemTextStyle: TextStyle(
                  color: appColors.textContrast,
                  fontSize: 16.0,
                ),
                confirmTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                selectionOverlay: Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: appColors.border!),
                    ),
                  ),
                ),
              ),
              dateFormat: 'yyyy|MMMM|dd',
              onConfirm: (date, _) {
                context.read<PersonalInfoBloc>().add(ChangeBornDateEvent(date));
              },
            );
          },
          validator: (_) {
            final bloc = context.read<PersonalInfoBloc>();
            final bornDate = bloc.state.personalInfo.bornDate;

            return bornDate == null //
                ? 'Este campo es obligatorio'
                : null;
          },
        );
      },
    );
  }
}
