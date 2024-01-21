import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/ui/utils/keyboard.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/suggestion/domain/entities/suggestion_entity.dart';
import 'package:healthy_app/features/client/suggestion/ui/bloc/suggestion_bloc.dart';

class SuggestionForm extends StatelessWidget {
  const SuggestionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputText(
            maxLines: 7,
            hintText: 'Escribe tu sugerencia aquí',
            textInputAction: TextInputAction.done,
            maxLength: 500,
            autofocus: true,
            validator: (_) {
              final bloc = context.read<SuggestionBloc>();
              final suggestion = bloc.state.form.suggestion;

              if (suggestion.valid) return null;

              switch (suggestion.error!) {
                case SuggestionValidationError.empty:
                  return 'Este campo es obligatorio';
              }
            },
            onChanged: (suggestion) {
              context
                  .read<SuggestionBloc>()
                  .add(ChangeSuggestionEvent(suggestion));
            },
          ),
          Spacer(),
          PrimaryButton(
            text: 'Enviar sugerencia',
            onPressed: () {
              Keyboard.close(context);
              if (!_formKey.currentState!.validate()) {
                return;
              }

              context.read<SuggestionBloc>().add(AddSuggestionEvent());
            },
          ),
        ],
      ),
    );
  }
}
