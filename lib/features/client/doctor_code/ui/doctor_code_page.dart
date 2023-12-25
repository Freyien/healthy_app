import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/domain/enums/saving_status.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/doctor_code/ui/bloc/doctor_code_bloc.dart';
import 'package:healthy_app/features/client/doctor_code/ui/widgets/doctor_code_form.dart';

class DoctorCodePage extends StatelessWidget {
  const DoctorCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DoctorCodeBloc>()..add(GetClientEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<DoctorCodeBloc, DoctorCodeState>(
            listenWhen: (p, c) => p.savingStatus != c.savingStatus,
            buildWhen: (p, c) => p.fetchingStatus != c.fetchingStatus,
            listener: _doctorCodeListener,
            builder: (context, state) {
              switch (state.fetchingStatus) {
                case FetchingStatus.initial:
                case FetchingStatus.loading:
                  // Loading
                  return Center(child: CircularProgressIndicator());
                case FetchingStatus.success:
                  // Show doctor code input
                  if (state.client.doctorId.isEmpty) return DoctorCodeForm();

                  _goHome(context);
                  return Center(child: CircularProgressIndicator());
                case FetchingStatus.failure:
                  // Failure
                  return ErrorFullScreen(onRetry: () {
                    context.read<DoctorCodeBloc>().add(GetClientEvent());
                  });
              }
            },
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
        return Toast.showError('Ha ocurrido un error inesperado.');
      case SavingStatus.success:
        LoadingUtils.hide(context);
        context.goNamed('home');
        break;
    }
  }

  void _goHome(BuildContext context) {
    Future.delayed(Duration(milliseconds: 450), () {
      context.goNamed('home');
    });
  }
}
