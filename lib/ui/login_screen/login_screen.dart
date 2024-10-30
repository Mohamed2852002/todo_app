import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/style/constants.dart';
import 'package:todo_app/style/reusable_components/custom_button.dart';
import 'package:todo_app/style/reusable_components/custom_text_field.dart';
import 'package:todo_app/ui/register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
          title: const Text('Login'),
          titleTextStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  label: 'E-Mail',
                  keyboardType: TextInputType.emailAddress,
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
                SizedBox(height: 30.h),
                const Text('Forgot Password ?'),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Login',
                  onClick: () {
                    login();
                  },
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text('Or Create An Account'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() {
    if (formKey.currentState?.validate() == true) {
      // some codes here
    }
  }
}
