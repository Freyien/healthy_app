import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/utils/keyboard.dart';
import 'package:healthy_app/features/client/personal_info/ui/bloc/personal_info_bloc.dart';

import '../../../../../core/ui/widgets/core_widgets.dart';

class PersonalInfoButton extends StatelessWidget {
  const PersonalInfoButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: 'Guardar',
      onPressed: () {
        Keyboard.close(context);
        if (!formKey.currentState!.validate()) return;

        context.read<PersonalInfoBloc>().add(SaveEvent());
      },
    );
  }
}
