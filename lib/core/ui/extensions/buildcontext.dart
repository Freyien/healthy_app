import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/constants/app_colors.dart';

extension BuildContextExtensions on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
