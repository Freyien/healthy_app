import 'package:flutter/material.dart';

class PaddingFormColumn extends StatelessWidget {
  const PaddingFormColumn({
    super.key,
    required this.children,
    required this.formKey,
    this.padding = const EdgeInsets.all(16),
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final EdgeInsetsGeometry padding;
  final List<Widget> children;
  final GlobalKey<FormState> formKey;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      ),
    );
  }
}
