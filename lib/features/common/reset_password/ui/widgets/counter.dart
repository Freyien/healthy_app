import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/entities/debouncer_entity.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/features/common/reset_password/ui/bloc/reset_password_bloc.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late DebouncerEntity debouncer;
  late int counter;

  @override
  void initState() {
    super.initState();
    debouncer = DebouncerEntity(milliseconds: 1000);
    runCounter();
  }

  void runCounter() {
    counter = 60;
    debouncer.periodic(() {
      counter--;

      if (counter == 0) {
        context.read<ResetPasswordBloc>().add(EnableButtonEvent());
        debouncer.cancel();
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listenWhen: (p, c) =>
          c.enabledButton == false && //
          p.enabledButton != c.enabledButton,
      listener: (context, state) => runCounter(),
      child: Text(
        'Reenviar en: $counter segundos',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.appColors.textContrast!.withOpacity(.7),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
