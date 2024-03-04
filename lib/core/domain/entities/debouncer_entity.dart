import 'dart:async';

import 'package:flutter/services.dart';

class DebouncerEntity {
  final int milliseconds;
  Timer? _timer = null;
  Timer? _periodic = null;

  DebouncerEntity({this.milliseconds = 350});

  void run(VoidCallback action) {
    cancel();

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void periodic(VoidCallback action) {
    cancel();

    _periodic = Timer.periodic(
      Duration(milliseconds: milliseconds),
      (_) => action(),
    );
  }

  void cancel() {
    _timer?.cancel();
    _periodic?.cancel();
  }
}
