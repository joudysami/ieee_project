import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.grey.shade100,
            borderRadius: BorderRadius.circular(16.r),
            border: Border(
              top: BorderSide(color: context.colors.sky.shade500, width: 5),
              // left: BorderSide(color: context.colors.sky.shade500, width: 1),
              // right: BorderSide(color: context.colors.sky.shade500, width: 1),
              // bottom: BorderSide(color: context.colors.sky.shade500, width: 1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 12.h),
              child: Column(
                children: [
                  Text(
                    AppString.welcome,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: context.colors.blue.shade500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppString.continueToDashboard,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: context.colors.blue.shade500,
                    ),
                  ),
              SizedBox(height: 20.h),
                  CustomeTextformfield(
                    text: AppString.email,
                    hintText: AppString.enterYourEmail,
                    icon: Icon(Icons.email, color: context.colors.primary),
                  ),
                  SizedBox(height: 20.h),
                  CustomeTextformfield(
                    text: AppString.password,
                    hintText: AppString.enterYourPassword,
                    icon: Icon(Icons.lock, color: context.colors.primary),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppString.forgetPassword,
                        style: TextStyle(color: context.colors.sky.shade700),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
              CustomeElevatebotton(
                    text: AppString.login,
                    icon: Icon(Icons.login, color: context.colors.white),
                  ),
              SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.dontHaveAccount,
                        style: TextStyle(color: context.colors.blue.shade500),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: context.colors.sky.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
