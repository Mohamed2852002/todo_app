// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/firestore/firestore_handler.dart';
import 'package:todo_app/firestore/models/user.dart' as myuser;
import 'package:todo_app/style/constants.dart';
import 'package:todo_app/style/firebase_auth_codes.dart';
import 'package:todo_app/style/reusable_components/custom_button.dart';
import 'package:todo_app/style/reusable_components/custom_loading_dialog.dart';
import 'package:todo_app/style/reusable_components/custom_message_dialog.dart';
import 'package:todo_app/style/reusable_components/custom_text_field.dart';
import 'package:todo_app/ui/home/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static const String routeName = 'register';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
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
                      keyboardType: TextInputType.phone,
                      label: 'Phone Number',
                      maxLength: 11,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Phone';
                        }
                        return null;
                      },
                      controller: phoneController,
                    ),
                    SizedBox(height: 14.h),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      label: 'Age',
                      maxLength: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Age';
                        }
                        return null;
                      },
                      controller: ageController,
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
                        createAccount(context);
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

  createAccount(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
        showDialog(
            context: context,
            builder: (context) => const CustomLoadingDialog());
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        await FirestoreHandler.createUser(
          myuser.User(
            fullName: nameController.text,
            email: emailController.text,
            id: credential.user?.uid,
            phone: phoneController.text,
            age: int.parse(ageController.text),
          ),
        );
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == FirebaseAuthCodes.weakPassword) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => CustomMessageDialog(
                  positiveBtnPressed: () {
                    Navigator.pop(context);
                  },
                  message: 'The password provided is too weak.'));
        } else if (e.code == FirebaseAuthCodes.existEmail) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => CustomMessageDialog(
                  positiveBtnPressed: () {
                    Navigator.pop(context);
                  },
                  message: 'The account already exists for that email.'));
        }
      } catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => CustomMessageDialog(
                positiveBtnPressed: () {
                  Navigator.pop(context);
                },
                message: 'An unexpected error occurred: $e'));
      }
    }
  }
}
