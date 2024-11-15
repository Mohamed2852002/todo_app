import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMessageDialog extends StatelessWidget {
  const CustomMessageDialog(
      {super.key,
      required this.message,
      this.positiveBtnTitle = 'Ok',
      required this.positiveBtnPressed,
      this.negativeBtnTitle,
      this.negativeBtnPressed});
  final String message;
  final String positiveBtnTitle;
  final Function() positiveBtnPressed;
  final String? negativeBtnTitle;
  final Function()? negativeBtnPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      content: Text(
        message,
        style: TextStyle(
          fontSize: 18.sp,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            positiveBtnPressed();
          },
          child: Text(
            positiveBtnTitle,
          ),
        ),
        if (negativeBtnTitle != null)
          TextButton(
            onPressed: () {
              negativeBtnPressed!();
            },
            child: Text(
              negativeBtnTitle!,
            ),
          ),
      ],
    );
  }
}
