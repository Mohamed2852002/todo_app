// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/firestore/firestore_handler.dart';
import 'package:todo_app/firestore/models/task.dart';
import 'package:todo_app/style/app_colors.dart';
import 'package:todo_app/style/constants.dart';
import 'package:todo_app/style/reusable_components/custom_loading_dialog.dart';
import 'package:todo_app/style/reusable_components/custom_message_dialog.dart';
import 'package:todo_app/ui/home/screens/edit_task_screen/edit_task_screen.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.34.w,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              bottomLeft: Radius.circular(15.r),
            ),
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (context) {
              deleteTask(context);
            },
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(
                task: task,
              ),
            ),
          );
        },
        child: Container(
          width: 350.w,
          height: 115.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.white,
          ),
          child: Row(
            children: [
              SizedBox(width: 20.w),
              Container(
                width: 4.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: task.isDone
                      ? AppColors.finishedTask
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 22.sp,
                            color: task.isDone
                                ? AppColors.finishedTask
                                : Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text(
                      task.description ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14.sp,
                            color: task.isDone
                                ? AppColors.finishedTask
                                : Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              task.isDone
                  ? Text(
                      'Done!',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 24.sp,
                            color: AppColors.finishedTask,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  : GestureDetector(
                      onTap: () {
                        updateTask(
                          {
                            'IsDone': true,
                          },
                        );
                      },
                      child: Container(
                        width: 70.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 32.r,
                        ),
                      ),
                    ),
              SizedBox(width: 20.w),
            ],
          ),
        ),
      ),
    );
  }

  deleteTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomMessageDialog(
        message: 'Are You Sure You Want to Delete This Task ?',
        negativeBtnTitle: 'No',
        positiveBtnTitle: 'Yes',
        negativeBtnPressed: () {
          Navigator.pop(context);
        },
        positiveBtnPressed: () async {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => const CustomLoadingDialog(),
          );
          await FirestoreHandler.deleteTask(
              FirebaseAuth.instance.currentUser!.uid, task.id ?? '');
          Navigator.pop(context);
          showCustomSnackBar(context, 'Task Deleted Successfully');
        },
      ),
    );
  }

  updateTask(Map<String, dynamic> data) async {
    await FirestoreHandler.updateTask(
        FirebaseAuth.instance.currentUser!.uid, task.id!, data);
  }
}
