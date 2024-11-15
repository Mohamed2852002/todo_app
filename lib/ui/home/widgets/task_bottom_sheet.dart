// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/firestore/firestore_handler.dart';
import 'package:todo_app/firestore/models/task.dart';
import 'package:todo_app/style/constants.dart';
import 'package:todo_app/style/reusable_components/custom_loading_dialog.dart';
import 'package:todo_app/style/reusable_components/custom_text_field.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  late TextEditingController taskController;
  late TextEditingController descriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    taskController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    taskController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          left: 40.w,
          right: 40.w,
          top: 30.h,
          bottom: MediaQuery.of(context).viewInsets.bottom == 0
              ? 30.h
              : MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Task',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 30.h),
            CustomTextField(
              label: 'Enter Your Task',
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Task';
                } else {
                  return null;
                }
              },
              controller: taskController,
            ),
            SizedBox(height: 30.h),
            CustomTextField(
              label: 'Enter Your Task Description',
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Description';
                } else {
                  return null;
                }
              },
              controller: descriptionController,
            ),
            SizedBox(height: 30.h),
            Text(
              'Date',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                showTaskDate();
              },
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Text(selectedDate != null
                    ? DateFormat.yMEd().format(selectedDate!).toString()
                    : DateFormat.yMEd().format(DateTime.now()).toString()),
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                addTask();
              },
              child: Container(
                height: 65.h,
                width: 65.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 34.r,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime? selectedDate;
  showTaskDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    selectedDate = date ?? selectedDate;
    setState(() {});
  }

  addTask() async {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context);
      showDialog(
          context: context, builder: (context) => const CustomLoadingDialog());
      await FirestoreHandler.createTask(
        Task(
          title: taskController.text,
          description: descriptionController.text,
          date: Timestamp.fromDate(
            selectedDate ??
                DateTime.now().copyWith(
                  hour: 0,
                  microsecond: 0,
                  millisecond: 0,
                  minute: 0,
                  second: 0,
                ),
          ),
        ),
        FirebaseAuth.instance.currentUser!.uid,
      );
      Navigator.pop(context);
      showCustomSnackBar(context, 'Task Added Successfully');
    }
  }
}
