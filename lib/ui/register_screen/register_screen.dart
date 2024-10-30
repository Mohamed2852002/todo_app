import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/style/constants.dart';
import 'package:todo_app/style/reusable_components/custom_button.dart';
import 'package:todo_app/style/reusable_components/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/back.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Create Account'),
          titleTextStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      label: 'Full Name',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                      controller: nameController,
                    ),
                    SizedBox(height: 14.h),
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      label: 'E-Mail Address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your E-Mail';
                        }
                        if (!isValidEmail(value)) {
                          return 'Please Enter a Proper E-Mail';
                        }
                        return null;
                      },
                      controller: emailController,
                    ),
                    SizedBox(height: 14.h),
                    CustomTextField(
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      label: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        if (value.length < 6) {
                          return 'Password Should be at least 6 characters';
                        }
                        return null;
                      },
                      controller: passwordController,
                    ),
                    SizedBox(height: 14.h),
                    CustomTextField(
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      label: 'Password Confirmation',
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'The Password must be the Same';
                        }
                        return null;
                      },
                      controller: passwordConfirmController,
                    ),
                    SizedBox(height: 50.h),
                    CustomButton(
                      text: 'Create Account',
                      onClick: () {
                        createAccount();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  createAccount() {
    if (formKey.currentState?.validate() == true) {
      // some codes here
    }
  }
}
