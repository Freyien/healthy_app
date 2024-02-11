import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/extensions/string.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/personal_info/ui/bloc/personal_info_bloc.dart';

class NameInput extends StatelessWidget {
  const NameInput({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return InputText(
      labelText: 'Nombre(s)',
      hintText: 'Nombre(s)',
      initialValue: name,
      onChanged: (value) =>
          context.read<PersonalInfoBloc>().add(ChangeNameEvent(value)),
      validator: (value) => value.isNullOrEmpty //
          ? 'Este campo es obligatorio'
          : null,
      prefixIcon: Icon(Icons.person),
      textInputAction: TextInputAction.next,
    );
  }
}
