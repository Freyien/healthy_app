import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_app/core/domain/enums/deleting_status.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/utils/loading.dart';
import 'package:healthy_app/core/ui/utils/toast.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/delete_account/ui/bloc/delete_account_bloc.dart';
import 'package:lottie/lottie.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return BlocProvider(
      create: (context) => sl<DeleteAccountBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Eliminar cuenta'),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final size = constraints.maxWidth * .7;

          return BlocListener<DeleteAccountBloc, DeleteAccountState>(
            listener: _deleteAccountListener,
            child: ScrollFillRemaining(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Spacer(),
                  FadeIn(
                    child: Lottie.asset(
                      'assets/animations/delete_account.json',
                      repeat: false,
                      fit: BoxFit.contain,
                      height: size,
                      width: size,
                    ),
                  ),
                  VerticalSpace.large(),
                  FadeInDown(
                    from: 20,
                    delay: Duration(milliseconds: 800),
                    child: Column(
                      children: [
                        Text(
                          '¿Seguro de borrar tu cuenta?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: appColors.textContrast,
                            letterSpacing: -.5,
                          ),
                        ),
                        VerticalSpace.small(),
                        Text(
                          'Este proceso no se puede revertir, toda tu información será borrada y no podrá recuperarse.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: appColors.textContrast!.withOpacity(.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  FadeInUp(
                    from: 20,
                    delay: Duration(milliseconds: 1500),
                    child: PrimaryButton(
                      text: 'Cancelar',
                      onPressed: () => context.pop(),
                    ),
                  ),
                  VerticalSpace.large(),
                  FadeInUp(
                    from: 20,
                    delay: Duration(milliseconds: 2000),
                    child: OutlinedButton(
                      onPressed: () => _showDeleteDialog(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: BorderSide(width: 1, color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.red,
                      ),
                      child: Text('Borrar cuenta para siempre 2/3'),
                    ),
                  ),
                  VerticalSpace.xxlarge(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (BuildContext dialogContext) {
        return AlertDialog.adaptive(
          backgroundColor: context.appColors.scaffold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: Text('Eliminar cuenta'),
          content: Text(
            'Este es el último paso para eliminar tu cuenta. Tu información no podrá ser recuperada.',
          ),
          actions: <Widget>[
            AdaptiveAction(
              onPressed: () {
                context.read<DeleteAccountBloc>().add(DeleteUserAccountEvent());
                Navigator.pop(dialogContext);
              },
              child: const Text('Eliminar 3/3'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAccountListener(BuildContext context, DeleteAccountState state) {
    switch (state.status) {
      case DeletingStatus.initial:
        break;
      case DeletingStatus.loading:
        LoadingUtils.show(context);
        break;
      case DeletingStatus.failure:
        LoadingUtils.hide(context);
        return Toast.showError('Ha ocurrido un error inesperado.');
      case DeletingStatus.success:
        LoadingUtils.hide(context);
        Future.delayed(Duration(milliseconds: 350), () {
          Toast.showSuccess('Tu cuenta ha sido eliminada de forma permanente');
        });

        context.pop();
        context.pushReplacementNamed('sign_up');
    }
  }
}
