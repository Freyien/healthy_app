import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/keyboard.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/doctor_code/ui/bloc/doctor_code_bloc.dart';

class DoctorCodeForm extends StatelessWidget {
  const DoctorCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final keyForm = GlobalKey<FormState>();

    return FadeInDown(
      key: UniqueKey(),
      from: 40,
      child: ScrollFillRemaining(
        child: PaddingFormColumn(
          formKey: keyForm,
          padding: EdgeInsets.zero,
          children: [
            Spacer(),

            // Image
            SvgPicture.asset(
              'assets/svg/doctor.svg',
              width: 128,
              height: 128,
            ),
            VerticalSpace.large(),

            // Title
            Text(
              'Ingresa el código de tu nutriólog@',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.appColors.textContrast,
                letterSpacing: -.5,
              ),
            ),
            VerticalSpace.xxsmall(),

            // Subtitle
            Text(
              'Solicita a tu nutriólog@ su código e ingresalo en el campo de abajo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: context.appColors.textContrast!.withOpacity(.7),
              ),
            ),
            VerticalSpace.medium(),

            // Input text
            InputText(
              labelText: 'Código',
              hintText: 'ABCDEFG',
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.done,
              prefixIcon: Icon(Icons.abc),
              onChanged: (value) {
                context.read<DoctorCodeBloc>().add(ChangeCodeEvent(value));
              },
              onFieldSubmitted: (_) {
                if (!keyForm.currentState!.validate()) return;
                context.read<DoctorCodeBloc>().add(SaveCodeEvent());
              },
              validator: (_) {
                final code = context.read<DoctorCodeBloc>().state.code;

                if (code.isEmpty) return 'Este campo es obligatorio';

                return null;
              },
            ),
            Spacer(),

            // Button
            FadeInUp(
              from: 30,
              key: UniqueKey(),
              delay: Duration(milliseconds: 400),
              duration: Duration(milliseconds: 550),
              child: PrimaryButton(
                text: 'Usar código',
                onPressed: () {
                  Keyboard.close(context);
                  if (!keyForm.currentState!.validate()) return;

                  context.read<DoctorCodeBloc>().add(SaveCodeEvent());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
