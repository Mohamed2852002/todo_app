// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/cubits/theme_cubit/theme_cubit.dart';
import 'package:todo_app/ui/home/screens/all_tasks_screen.dart/all_tasks_screen.dart';
import 'package:todo_app/ui/login/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String currentLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200.h,
          child: AppBar(
            toolbarHeight: 100.h,
            titleSpacing: 50.w,
            title: const Text('Settings'),
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const RSizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.w),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    padding: REdgeInsets.only(
                      left: 16,
                    ),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter'),
                    isExpanded: true,
                    hint: const Text('Choose Language'),
                    value: currentLanguage,
                    items: ['English', 'Arabic'].map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      currentLanguage = value!;
                      setState(() {});
                    },
                  ),
                ),
              ),
              const RSizedBox(height: 30),
              Row(
                children: [
                  Text(
                    'Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Light',
                    style: TextStyle(
                        color: BlocProvider.of<ThemeCubit>(context).isDark
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins'),
                  ),
                  const RSizedBox(width: 5),
                  Switch(
                    value: BlocProvider.of<ThemeCubit>(context).isDark,
                    onChanged: (value) {
                      BlocProvider.of<ThemeCubit>(context).isDark = value;
                      BlocProvider.of<ThemeCubit>(context).changeTheme();
                      setState(() {});
                    },
                  ),
                  const RSizedBox(width: 5),
                  Text(
                    'Dark',
                    style: TextStyle(
                      color: BlocProvider.of<ThemeCubit>(context).isDark
                          ? Theme.of(context).colorScheme.primary
                          : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const RSizedBox(height: 50),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AllTasksScreen.routeName);
                  },
                  child: Text(
                    'See All Tasks',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
