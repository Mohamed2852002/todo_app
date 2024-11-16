// ignore_for_file: use_build_context_synchronously

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/firestore/firestore_handler.dart';
import 'package:todo_app/firestore/models/task.dart';
import 'package:todo_app/ui/home/widgets/task_widget.dart';
import 'package:todo_app/ui/login/login_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RSizedBox(
          height: 235,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 200.h,
                child: AppBar(
                  toolbarHeight: 100.h,
                  titleSpacing: 50.w,
                  title: const Text('To Do List'),
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
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: EasyInfiniteDateTimeLine(
                  timeLineProps: EasyTimeLineProps(
                    separatorPadding: 20.w,
                  ),
                  showTimelineHeader: false,
                  dayProps: EasyDayProps(
                    width: 60.w,
                    height: 80.h,
                    todayStyle: DayStyle(
                      dayStrStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      monthStrStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      dayNumStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      dayStrStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      monthStrStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      dayNumStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  firstDate: DateTime.now(),
                  focusDate: selectedDate,
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateChange: (newDate) {
                    setState(
                      () {
                        selectedDate = newDate;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: StreamBuilder(
            stream: FirestoreHandler.getSortedTasks(
                FirebaseAuth.instance.currentUser!.uid, selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('There was an Error'),
                );
              }
              List<Task> tasks = snapshot.data ?? [];
              return ListView.separated(
                padding: REdgeInsets.symmetric(horizontal: 30, vertical: 25),
                itemCount: tasks.length,
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                itemBuilder: (context, index) => TaskWidget(task: tasks[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
