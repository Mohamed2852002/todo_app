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

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.task});
  static const String routeName = 'edit';
  final Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = true;
  initTask() {
    titleController.text = widget.task.title ?? '';
    descriptionController.text = widget.task.description ?? '';
    selectedDate = DateTime.fromMillisecondsSinceEpoch(
        widget.task.date?.millisecondsSinceEpoch ??
            DateTime.now()
                .copyWith(
                  second: 0,
                  millisecond: 0,
                  microsecond: 0,
                  minute: 0,
                  hour: 0,
                )
                .millisecondsSinceEpoch);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    initTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: Stack(
        children: [
          Container(
            height: 100.h,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
          ),
          Stack(
            children: [
              Positioned(
                top: 40.h,
                left: (1.sw - 350.w) / 2,
                child: Container(
                  padding: REdgeInsets.symmetric(horizontal: 20),
                  width: 350.w,
                  height: 620.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            const RSizedBox(height: 30),
                            Text(
                              'Edit Task',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const RSizedBox(height: 50),
                            CustomTextField(
                              label: 'New Title',
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              controller: titleController,
                            ),
                            const RSizedBox(height: 20),
                            CustomTextField(
                              label: 'New Description',
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                return null;
                              },
                              controller: descriptionController,
                            ),
                            const RSizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Is Task Done ?',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                RadioMenuButton(
                                  value: true,
                                  groupValue: widget.task.isDone,
                                  onChanged: (value) {
                                    FirestoreHandler.updateTask(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      widget.task.id!,
                                      {
                                        'IsDone': true,
                                      },
                                    );
                                    widget.task.isDone = true;
                                    setState(() {});
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                RadioMenuButton(
                                  value: false,
                                  groupValue: widget.task.isDone,
                                  onChanged: (value) {
                                    FirestoreHandler.updateTask(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      widget.task.id!,
                                      {
                                        'IsDone': false,
                                      },
                                    );
                                    widget.task.isDone = false;
                                    setState(() {});
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const RSizedBox(height: 30),
                            Text(
                              'Date',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const RSizedBox(height: 10),
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
                                    ? DateFormat.yMEd()
                                        .format(selectedDate!)
                                        .toString()
                                    : DateFormat.yMEd()
                                        .format(DateTime.now())
                                        .toString()),
                              ),
                            ),
                            const RSizedBox(height: 90),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: REdgeInsets.symmetric(
                                      vertical: 16, horizontal: 65),
                                  backgroundColor: Theme.of(context).colorScheme.primary,),
                              onPressed: () {
                                updateTask(
                                  {
                                    'Title': titleController.text,
                                    'Description': descriptionController.text,
                                    'Date': Timestamp.fromDate(
                                      selectedDate ??
                                          DateTime.now().copyWith(
                                            hour: 0,
                                            microsecond: 0,
                                            millisecond: 0,
                                            minute: 0,
                                            second: 0,
                                          ),
                                    ),
                                  },
                                );
                              },
                              child: Text(
                                'Save Changes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              )
            ],
          ),
        ],
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

  updateTask(Map<String, dynamic> data) async {
    showDialog(
      context: context,
      builder: (context) => const CustomLoadingDialog(),
    );
    await FirestoreHandler.updateTask(
        FirebaseAuth.instance.currentUser!.uid, widget.task.id!, data);
    showCustomSnackBar(context, 'Task Edited Successfully');
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
