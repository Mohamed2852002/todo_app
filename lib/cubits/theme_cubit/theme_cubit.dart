import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/cubits/theme_cubit/theme_states.dart';
import 'package:todo_app/style/app_themes.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit(bool isSwitched) : super(LightState()) {
    isDark = isSwitched;
  }
  ThemeData selectedTheme = AppThemes.lightTheme;
  bool isDark = false;

  changeTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isDark) {
      selectedTheme = AppThemes.darkTheme;
      isDark = true;
      prefs.setBool('isDark', true);
      emit(DarkState());
    } else {
      selectedTheme = AppThemes.lightTheme;
      isDark = false;
      prefs.setBool('isDark', false);
      emit(LightState());
    }
  }
}
