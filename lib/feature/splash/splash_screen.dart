import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_icons.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: context.colors.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppIcons.appLogo_white,
                width: 200.w,
                height: 200.h,
              ),
            ),
            FadeInLeft(
              duration: Duration(seconds: 3),
              child: Text(
                AppString.branch,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: context.colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            FadeInRight(
              duration: Duration(seconds: 3),
              child: Text(
                AppString.splash,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:context.colors.white,
                ),
              ),
               onFinish: (dirction){
                context.go('/loginScreen');
              },
            ),
          
          ],
        ),
      ),
    );
  }
}
