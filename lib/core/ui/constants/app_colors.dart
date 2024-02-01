import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.darkCharcoal,
    required this.flashWhite,
    required this.border,
    required this.borderBold,
    required this.textContrast,
    required this.scaffold,
    required this.primaryText,
    required this.input,
    required this.loadingBackground,
    required this.loadingBase,
    required this.loadingHighlight,
    required this.shadow,
    required this.gainsboro,
    required this.appbar,
    required this.water,
    required this.navigationBar,
    required this.unselectedItemColor,
  });

  final Color? primary;
  final Color? darkCharcoal;
  final Color? flashWhite;
  final Color? border;
  final Color? borderBold;
  final Color? textContrast;
  final Color? scaffold;
  final Color? primaryText;
  final Color? input;
  final Color? loadingBackground;
  final Color? loadingBase;
  final Color? loadingHighlight;
  final Color? shadow;
  final Color? gainsboro;
  final Color? appbar;
  final Color? water;
  final Color? navigationBar;
  final Color? unselectedItemColor;

  bool get isDark => scaffold == DarkColors.scaffold;

  @override
  AppColors copyWith({
    Color? primary,
    Color? darkCharcoal,
    Color? flashWhite,
    Color? border,
    Color? borderBold,
    Color? textContrast,
    Color? scaffold,
    Color? primaryText,
    Color? input,
    Color? loadingBackground,
    Color? loadingBase,
    Color? loadingHighlight,
    Color? shadow,
    Color? gainsboro,
    Color? appbar,
    Color? water,
    Color? navigationBar,
    Color? unselectedItemColor,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      darkCharcoal: darkCharcoal ?? this.darkCharcoal,
      flashWhite: flashWhite ?? this.flashWhite,
      border: border ?? this.border,
      borderBold: borderBold ?? this.borderBold,
      textContrast: textContrast ?? this.textContrast,
      scaffold: scaffold ?? this.scaffold,
      primaryText: primaryText ?? this.primaryText,
      input: input ?? this.input,
      loadingBackground: loadingBackground ?? this.loadingBackground,
      loadingBase: loadingBase ?? this.loadingBase,
      loadingHighlight: loadingHighlight ?? this.loadingHighlight,
      shadow: shadow ?? this.shadow,
      gainsboro: gainsboro ?? this.gainsboro,
      appbar: appbar ?? this.appbar,
      water: water ?? this.water,
      navigationBar: navigationBar ?? this.navigationBar,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      darkCharcoal: Color.lerp(darkCharcoal, other.darkCharcoal, t),
      flashWhite: Color.lerp(flashWhite, other.flashWhite, t),
      border: Color.lerp(border, other.border, t),
      borderBold: Color.lerp(borderBold, other.borderBold, t),
      textContrast: Color.lerp(textContrast, other.textContrast, t),
      scaffold: Color.lerp(scaffold, other.scaffold, t),
      primaryText: Color.lerp(primaryText, other.primaryText, t),
      input: Color.lerp(input, other.input, t),
      loadingBackground:
          Color.lerp(loadingBackground, other.loadingBackground, t),
      loadingBase: Color.lerp(loadingBase, other.loadingBase, t),
      loadingHighlight: Color.lerp(loadingHighlight, other.loadingHighlight, t),
      shadow: Color.lerp(shadow, other.shadow, t),
      gainsboro: Color.lerp(gainsboro, other.gainsboro, t),
      appbar: Color.lerp(appbar, other.appbar, t),
      water: Color.lerp(water, other.water, t),
      navigationBar: Color.lerp(navigationBar, other.navigationBar, t),
      unselectedItemColor:
          Color.lerp(unselectedItemColor, other.unselectedItemColor, t),
    );
  }
}

// class DefaultColors {
//   DefaultColors();

//   static const Color primary = Colors.blue;
//   static const Color darkCharcoal = Color(0xff333333);
//   static const Color flashWhite = Color(0xfff0f0f0);
//   static const Color borderBold = Color(0xffCCCCCC);
//   static const Color gainsboro = Color(0xffCCCCCC);
//   static const Color water = Colors.blue;
// }

// class DarkColors {
//   static const Color textContrast = Colors.white;
//   static const Color scaffold = const Color(0xff222224);
//   static const Color primaryText = Colors.white;
//   static const Color input = const Color(0xFF4c4b50);
//   static Color loadingBackground = Colors.grey[700]!;
//   static Color loadingBase = Colors.black54;
//   static Color loadingHighlight = Colors.grey[900]!;
//   static const Color shadow = Colors.black54;
//   static const Color border = Color(0xFF4c4b50);
//   static const Color appbar = Color(0xff27252E);
//   static const Color? navigationBar = Color(0xff27252E);
//   static const Color? unselectedItemColor = null;
// }

// class LightColors {
//   static const Color textContrast = Colors.black;
//   static Color scaffold = Colors.grey[50]!;
//   static const Color primaryText = Color(0xFF595959);
//   static const Color input = Color(0xfff0f0f0);
//   static Color loadingBackground = Colors.grey[200]!;
//   static Color loadingBase = Colors.grey[300]!;
//   static Color loadingHighlight = Colors.grey[400]!;
//   static const Color shadow = Color(0xffDDDDDD);
//   static const Color border = Color(0xffDDDDDD);
//   static const Color appbar = Color(0xffE3DFEB);
//   static const Color? navigationBar = null;
//   static const Color? unselectedItemColor = null;
// }

class DefaultColors {
  DefaultColors();

  static const Color primary = Color(0xffFFB685);
  static const Color darkCharcoal = Color(0xff333333);
  static const Color flashWhite = Color(0xfff0f0f0);
  static const Color borderBold = Color(0xffCCCCCC);
  static const Color gainsboro = Color(0xffCCCCCC);
  static const Color water = Color(0xff4bbad4);
}

class DarkColors {
  static const Color textContrast = Colors.white;
  static const Color scaffold = const Color(0xff222224);
  static const Color primaryText = Colors.white;
  static const Color input = const Color(0xFF4c4b50);
  static Color loadingBackground = Colors.grey[700]!;
  static Color loadingBase = Colors.black54;
  static Color loadingHighlight = Colors.grey[900]!;
  static const Color shadow = Colors.black54;
  static const Color border = Color(0xFF4c4b50);
  static const Color appbar = Color(0xff27252E);
  static const Color navigationBar = Color(0xff27252E);
  static const Color unselectedItemColor = Colors.grey;
}

class LightColors {
  static const Color textContrast = Colors.white;
  static Color scaffold = Color(0xff4D6A67);
  static const Color primaryText = Color(0xFF595959);
  static Color input = Color(0xff678E89);
  static Color loadingBackground = Color(0xff678E89).withOpacity(.6);
  static Color loadingBase = Color(0xff678E89).withOpacity(.8);
  static Color loadingHighlight = Color(0xff678E89);
  static const Color shadow = Color(0xffDDDDDD);
  static const Color border = Color(0xffDDDDDD);
  static const Color appbar = Color(0xff678E89);
  static const Color navigationBar = Color(0xff678E89);
  static const Color unselectedItemColor = Colors.white;
}

// class DefaultColors {
//   DefaultColors();

//   static const Color primary = Color(0xfffd785c);
//   static const Color darkCharcoal = Color(0xff333333);
//   static const Color flashWhite = Color(0xfff0f0f0);
//   static const Color borderBold = Color(0xffCCCCCC);
//   static const Color gainsboro = Color(0xffCCCCCC);
//   static const Color water = Color(0xff4bbad4);
// }

// class DarkColors {
//   static const Color textContrast = Colors.white;
//   static const Color scaffold = const Color(0xff222224);
//   static const Color primaryText = Colors.white;
//   static const Color input = const Color(0xFF4c4b50);
//   static Color loadingBackground = Colors.grey[700]!;
//   static Color loadingBase = Colors.black54;
//   static Color loadingHighlight = Colors.grey[900]!;
//   static const Color shadow = Colors.black54;
//   static const Color border = Color(0xFF4c4b50);
//   static const Color appbar = Color(0xff27252E);
//   static const Color navigationBar = Color(0xff27252E);
//   static const Color unselectedItemColor = Colors.grey;
// }

// class LightColors {
//   static const Color textContrast = Colors.black;
//   static Color scaffold = Color(0xffD6E4FF);
//   static const Color primaryText = Color(0xFF595959);
//   static Color input = Colors.white.withOpacity(.8);
//   static Color loadingBackground = Colors.grey[200]!;
//   static Color loadingBase = Colors.grey[300]!;
//   static Color loadingHighlight = Colors.grey[400]!;
//   static const Color shadow = Color(0xffDDDDDD);
//   static const Color border = Color(0xffDDDDDD);
//   static const Color appbar = Color(0xffEBF1FF);
//   static const Color navigationBar = Color(0xffEBF1FF);
//   static const Color unselectedItemColor = Colors.grey;
// }
