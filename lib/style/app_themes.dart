import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/style/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      enableFeedback: false,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightPrimaryColor,
      primary: AppColors.lightPrimaryColor,
      secondary: AppColors.backgroundLightColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
      ),
    ),
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColors.lightPrimaryColor,
    ),
  );
}
