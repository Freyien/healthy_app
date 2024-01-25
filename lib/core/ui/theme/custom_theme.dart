import 'package:flutter/material.dart';
import 'package:healthy_app/core/ui/constants/app_colors.dart';

class CustomTheme {
  static ThemeData get dolceTheme {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: LightColors.scaffold,
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: DefaultColors.primary, // TextFormField focus color icon
            secondary: DefaultColors.primary,
          ),
      focusColor: DefaultColors.primary,
      hintColor: DefaultColors.primary,
      primaryColor: DefaultColors.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: LightColors.scaffold,
        elevation: 3,
        iconTheme: IconThemeData(
          color: LightColors.textContrast,
        ),
        titleTextStyle: TextStyle(
          color: LightColors.textContrast,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: DefaultColors.flashWhite,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: TextStyle(
          color: LightColors.primaryText.withOpacity(.5),
        ),
        labelStyle: TextStyle(
          color: LightColors.primaryText,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: LightColors.input),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: LightColors.input),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: LightColors.input),
          borderRadius: BorderRadius.circular(10),
        ),
        iconColor: LightColors.primaryText.withOpacity(.7),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: DefaultColors.primary,
        selectionColor: DefaultColors.primary,
        selectionHandleColor: DefaultColors.primary,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: LightColors.textContrast,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return LightColors.textContrast.withOpacity(.3);
              }
              return LightColors.textContrast;
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return DefaultColors.primary.withOpacity(.1);
            },
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(),
      dialogTheme: DialogTheme(
        backgroundColor: LightColors.scaffold,
        elevation: 0,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppColors(
          primary: DefaultColors.primary,
          darkCharcoal: DefaultColors.darkCharcoal,
          flashWhite: DefaultColors.flashWhite,
          border: LightColors.border,
          borderBold: DefaultColors.borderBold,
          textContrast: LightColors.textContrast,
          scaffold: LightColors.scaffold,
          primaryText: LightColors.primaryText,
          input: LightColors.input,
          loadingBackground: LightColors.loadingBackground,
          loadingBase: LightColors.loadingBase,
          loadingHighlight: LightColors.loadingHighlight,
          shadow: LightColors.shadow,
          gainsboro: DefaultColors.gainsboro,
        ),
      ],
    );
  }

  static ThemeData get dolceDarkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: DarkColors.scaffold,
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: DefaultColors.primary, // TextFormField focus color icon
            secondary: DefaultColors.primary,
          ),
      focusColor: DefaultColors.primary,
      hintColor: DefaultColors.primary,
      primaryColor: DefaultColors.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: DarkColors.scaffold,
        elevation: 3,
        iconTheme: const IconThemeData(
            // color: AppColors.black,
            ),
        titleTextStyle: const TextStyle(
          // color: AppColors.black,

          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        // surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: DarkColors.input,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: TextStyle(
          color: DarkColors.primaryText.withOpacity(.6),
        ),
        labelStyle: TextStyle(
          color: DarkColors.primaryText,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: DarkColors.input),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DarkColors.input),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DarkColors.input),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIconColor: DarkColors.primaryText.withOpacity(.7),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: DefaultColors.primary,
        selectionColor: DefaultColors.primary,
        selectionHandleColor: DefaultColors.primary,
      ),
      cardTheme: CardTheme(
        color: DefaultColors.darkCharcoal,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: DarkColors.textContrast,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return DarkColors.textContrast.withOpacity(.3);
              }

              return DarkColors.textContrast;
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return DefaultColors.primary.withOpacity(.1);
            },
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(),
      dialogTheme: DialogTheme(
        backgroundColor: DarkColors.scaffold,
        elevation: 0,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppColors(
          primary: DefaultColors.primary,
          darkCharcoal: DefaultColors.darkCharcoal,
          flashWhite: DefaultColors.flashWhite,
          border: DarkColors.border,
          borderBold: DefaultColors.borderBold,
          textContrast: DarkColors.textContrast,
          scaffold: DarkColors.scaffold,
          primaryText: DarkColors.primaryText,
          input: DarkColors.input,
          loadingBackground: DarkColors.loadingBackground,
          loadingBase: DarkColors.loadingBase,
          loadingHighlight: DarkColors.loadingHighlight,
          shadow: DarkColors.shadow,
          gainsboro: DefaultColors.gainsboro,
        ),
      ],
    );
  }
}
