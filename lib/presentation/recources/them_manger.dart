import 'package:flutter/material.dart';
import 'package:soq_app/presentation/recources/color_manger.dart';
import 'package:soq_app/presentation/recources/fonts_manger.dart';
import 'package:soq_app/presentation/recources/styles_manger.dart';
import 'package:soq_app/presentation/recources/values_manger.dart';

ThemeData getThemData() {
  return ThemeData(
    primaryColor: ColorsManger.primary,
    disabledColor: ColorsManger.grey,
    cardTheme: const CardTheme(
      color: ColorsManger.white,
      elevation: AppSize.s4,
      shadowColor: ColorsManger.grey,
    ),
    appBarTheme: AppBarTheme(
      color: ColorsManger.primary,
      elevation: AppSize.s4,
      centerTitle: true,
      shadowColor: ColorsManger.lightGrey,
      titleTextStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorsManger.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ColorsManger.primary,
      unselectedItemColor: ColorsManger.lightGrey,
      backgroundColor: ColorsManger.erorr,
      elevation: AppSize.s20,
    ),
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorsManger.primary,
      disabledColor: ColorsManger.grey,
      splashColor: ColorsManger.lightPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorsManger.primary,
        textStyle: getRegularStyle(
          color: ColorsManger.white,
          fontSize: FontSize.s17,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: getBoldStyle(
        color: ColorsManger.black,
        fontSize: FontSize.s18,
      ),
      titleMedium: getBoldStyle(
        color: ColorsManger.black,
        fontSize: FontSize.s18,
      ),
      titleSmall: getRegularStyle(
        color: ColorsManger.white,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getRegularStyle(
        color: ColorsManger.darkGrey,
        fontSize: FontSize.s14,
      ),
      bodyLarge: getBoldStyle(
        color: ColorsManger.primary,
        fontSize: 18,
      ),
      bodySmall: getBoldStyle(
        color: ColorsManger.white,
        fontSize: FontSize.s14,
      ),
      displayMedium: getBoldStyle(
        color: ColorsManger.primary,
        fontSize: FontSize.s20,
      ),
      displaySmall: getBoldStyle(
        color: ColorsManger.blue,
        fontSize: FontSize.s20,
      ),
      displayLarge: getLightStyle(
        color: ColorsManger.darkGrey,
        fontSize: FontSize.s16,
      ),
      labelSmall: getBoldStyle(
        color: ColorsManger.blue,
        fontSize: FontSize.s18,
      ),
      bodyMedium: getBoldStyle(
        color: ColorsManger.primary,
        fontSize: FontSize.s18,
      ),
      headlineSmall: getBoldStyle(
        color: ColorsManger.white,
        fontSize: FontSize.s8,
      ),
      titleLarge: getSemiBoldStyle(
        color: ColorsManger.lightGrey,
        fontSize: FontSize.s18,
      ),
      labelLarge: getBoldStyle(
        color: ColorsManger.white,
        fontSize: FontSize.s22,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle:
          getRegularStyle(color: ColorsManger.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorsManger.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorsManger.erorr),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManger.grey, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorsManger.primary, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManger.erorr, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorsManger.primary, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}
