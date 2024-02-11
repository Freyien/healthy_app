import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/string.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/personal_info/ui/bloc/personal_info_bloc.dart';

class SecondnameInput extends StatelessWidget {
  const SecondnameInput({super.key, required this.secondname});

  final String secondname;

  @override
  Widget build(BuildContext context) {
    return InputText(
      labelText: 'Apellido materno',
      hintText: 'Apellido materno',
      initialValue: secondname,
      onChanged: (value) =>
          context.read<PersonalInfoBloc>().add(ChangeSecondname(value)),
      validator: (value) => value.isNullOrEmpty //
          ? 'Este campo es obligatorio'
          : null,
      prefixIcon: Icon(Icons.person),
      textInputAction: TextInputAction.done,
    );
  }
}
