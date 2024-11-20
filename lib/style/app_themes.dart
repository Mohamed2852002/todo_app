import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/style/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 18.sp,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 20.sp,
      ),
      labelSmall:  TextStyle(
          fontSize: 12.sp,
          color: Colors.grey,
        ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      enableFeedback: false,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightPrimary,
      primary: AppColors.lightPrimary,
      secondary: Colors.white,
      tertiary: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
      ),
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: AppColors.lightPrimary,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 18.sp,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 20.sp,
         color: Colors.white,
      ),
      labelSmall:  TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
        ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      enableFeedback: false,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightPrimary,
      primary: AppColors.lightPrimary,
      secondary: AppColors.darkSecondary,
      tertiary: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
      ),
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: AppColors.lightPrimary,
    ),
  );
}
