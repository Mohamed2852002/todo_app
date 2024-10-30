import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.label,
    required this.keyboardType,
    this.isPassword = false,
    required this.validator, required this.controller,
  });
  final String label;
  final TextInputType keyboardType;
  bool isPassword;
  final String? Function(String?) validator;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
      ),
      decoration: InputDecoration(
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
                onPressed: () {
                  widget.isPassword = !widget.isPassword;
                  setState(() {});
                },
                icon: Icon(
                  widget.isPassword ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : null,
        labelText: widget.label,
      ),
    );
  }
}
