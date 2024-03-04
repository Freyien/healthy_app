import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/string.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/personal_info/ui/bloc/personal_info_bloc.dart';

class FirstnameInput extends StatelessWidget {
  const FirstnameInput({super.key, required this.firstname});

  final String firstname;

  @override
  Widget build(BuildContext context) {
    return InputText(
      labelText: 'Apellido paterno',
      hintText: 'Apellido paterno',
      initialValue: firstname,
      onChanged: (value) =>
          context.read<PersonalInfoBloc>().add(ChangeFirstnameEvent(value)),
      validator: (value) => value.isNullOrEmpty //
          ? 'Este campo es obligatorio'
          : null,
      prefixIcon: Icon(Icons.person),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
    );
  }
}
