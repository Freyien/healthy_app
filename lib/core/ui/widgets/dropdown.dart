import 'package:flutter/material.dart';

class Dropdown<T> extends StatelessWidget {
  const Dropdown({
    super.key,
    this.labelText = '',
    this.hintText = '',
    this.enabled = true,
    required this.onChanged,
    required this.items,
    this.prefixIcon,
    this.validator,
    this.value,
  });

  final String labelText;
  final String hintText;
  final bool enabled;
  final void Function(T?) onChanged;
  final List<DropdownMenuItem<T>> items;
  final Widget? prefixIcon;
  final String? Function(T?)? validator;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 8),
              child: Text(
                labelText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          _Enable(
            enabled: enabled,
            child: DropdownButtonFormField<T>(
              value: value,
              items: items,
              onChanged: onChanged,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              validator: validator,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: prefixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Enable extends StatelessWidget {
  const _Enable({required this.enabled, this.child});

  final bool enabled;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final opacity = enabled ? 1.0 : .5;
    final absorbing = !enabled;

    return Opacity(
      opacity: opacity,
      child: AbsorbPointer(
        absorbing: absorbing,
        child: child,
      ),
    );
  }
}
