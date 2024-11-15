import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/firestore/firestore_handler.dart';
import 'package:todo_app/firestore/models/task.dart';
import 'package:todo_app/ui/home/widgets/task_widget.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});
  static const String routeName = 'allTasks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200.h,
            child: AppBar(
              toolbarHeight: 100.h,
              titleSpacing: 50.w,
              title: const Text('All Tasks'),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreHandler.getAllTasks(
                  FirebaseAuth.instance.currentUser!.uid),
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
                  itemBuilder: (context, index) =>
                      TaskWidget(task: tasks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
