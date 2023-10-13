import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';

class InputText extends StatelessWidget {
  const InputText({
    super.key,
    this.labelText = '',
    this.hintText,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.initialValue,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.helpText,
    this.fillColor,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.onTap,
    this.disabledopacity = 0.5,
    this.contentPadding,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
  });

  final String labelText;
  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextAlign textAlign;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? helpText;
  final Color? fillColor;
  final EdgeInsetsGeometry padding;
  final Function()? onTap;
  final double disabledopacity;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
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
            disabledopacity: disabledopacity,
            child: TextFormField(
              maxLength: maxLength,
              maxLines: maxLines,
              obscureText: obscureText,
              initialValue: initialValue,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              onChanged: onChanged,
              textAlign: textAlign,
              validator: validator,
              textCapitalization: textCapitalization,
              onTap: onTap,
              readOnly: readOnly,
              decoration: InputDecoration(
                contentPadding: contentPadding,
                fillColor: fillColor,
                helperText: helpText,
                hintText: hintText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                helperStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.appColors.primaryText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Enable extends StatelessWidget {
  const _Enable({
    required this.enabled,
    this.child,
    required this.disabledopacity,
  });

  final bool enabled;
  final Widget? child;
  final double disabledopacity;

  @override
  Widget build(BuildContext context) {
    final opacity = enabled ? 1.0 : disabledopacity;
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
