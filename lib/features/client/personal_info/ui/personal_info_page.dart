import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/personal_info/ui/bloc/personal_info_bloc.dart';
import 'package:healthy_app/features/client/personal_info/ui/widgets/born_date_input.dart';
import 'package:healthy_app/features/client/personal_info/ui/widgets/firstname_input.dart';
import 'package:healthy_app/features/client/personal_info/ui/widgets/name_input.dart';
import 'package:healthy_app/features/client/personal_info/ui/widgets/personal_info_button.dart';
import 'package:healthy_app/features/client/personal_info/ui/widgets/secondname_input.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => sl<PersonalInfoBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Información personal'),
        ),
        body: BlocListener<PersonalInfoBloc, PersonalInfoState>(
          listenWhen: (p, c) => p.savingStatus != c.savingStatus,
          listener: _personalInfoListener,
          child: ScrollFillRemaining(
            child: PaddingFormColumn(
              formKey: formKey,
              padding: EdgeInsets.zero,
              children: [
                Text(
                    'Esta información le ayudará a tu nutriólogo a identificarte de manera más sencilla.'),
                VerticalSpace.large(),

                // Name
                NameInput(),

                // Firstname
                FirstnameInput(),

                // Secondname
                SecondnameInput(),

                // Born date
                BornDateInput(),
                Spacer(),

                // Button
                VerticalSpace.large(),
                PersonalInfoButton(formKey: formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _personalInfoListener(BuildContext context, PersonalInfoState state) {
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
        LoadingUtils.hide(context);
        return context.goNamed('doctor_code');
    }
  }
}
