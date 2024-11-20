import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/cubits/theme_cubit/theme_cubit.dart';
import 'package:todo_app/cubits/theme_cubit/theme_states.dart';
import 'package:todo_app/style/app_themes.dart';
import 'package:todo_app/ui/home/home_screen.dart';
import 'package:todo_app/ui/home/screens/all_tasks_screen.dart/all_tasks_screen.dart';
import 'package:todo_app/ui/login/login_screen.dart';
import 'package:todo_app/ui/register/register_screen.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key, required this.prefs});
  final SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(prefs.getBool('isDark') ?? false),
      child: ScreenUtilInit(
        designSize: const Size(412, 870),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => Builder(
          builder: (context) {
            return BlocBuilder<ThemeCubit, ThemeStates>(
              builder: (context, state) {
                return MaterialApp(
                  initialRoute: FirebaseAuth.instance.currentUser == null
                      ? LoginScreen.routeName
                      : HomeScreen.routeName,
                  routes: {
                    HomeScreen.routeName: (context) => const HomeScreen(),
                    LoginScreen.routeName: (context) => LoginScreen(),
                    RegisterScreen.routeName: (context) => RegisterScreen(),
                    AllTasksScreen.routeName: (context) =>
                        const AllTasksScreen(),
                  },
                  theme: prefs.getBool('isDark') ?? false
                      ? AppThemes.darkTheme
                      : AppThemes.lightTheme,
                  debugShowCheckedModeBanner: false,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
