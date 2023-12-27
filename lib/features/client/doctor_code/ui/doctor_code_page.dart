import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/domain/failures/failures.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/doctor_code/domain/failures/doctor_code_failures.dart';
import 'package:healthy_app/features/client/doctor_code/ui/bloc/doctor_code_bloc.dart';
import 'package:healthy_app/features/client/doctor_code/ui/widgets/doctor_code_form.dart';

class DoctorCodePage extends StatelessWidget {
  const DoctorCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DoctorCodeBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<DoctorCodeBloc, DoctorCodeState>(
            listenWhen: (p, c) => p.savingStatus != c.savingStatus,
            listener: _doctorCodeListener,
            child: DoctorCodeForm(),
          ),
        ),
      ),
    );
  }

  void _doctorCodeListener(BuildContext context, DoctorCodeState state) {
    switch (state.savingStatus) {
      case SavingStatus.initial:
        break;
      case SavingStatus.loading:
        LoadingUtils.show(context);
        break;
      case SavingStatus.failure:
        LoadingUtils.hide(context);
        return _showError(state.failure);
      case SavingStatus.success:
        LoadingUtils.hide(context);
        return context.goNamed('home');
    }
  }

  void _showError(Failure failure) {
    if (failure is DoctorDoesNotExistsFailure) {
      return Toast.showError(
          'Código incorrecto, verifica y vuelve a intentar.');
    }

    return Toast.showError('Ha ocurrido un error inesperado.');
  }
}
