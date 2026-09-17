import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/theme/app_colors.dart';

class HomeContiner extends StatelessWidget {
  final String title;
  final String icon;
  final String num;
  const HomeContiner({
    super.key,
    required this.title,
    required this.icon,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.grey.shade500,
          borderRadius: BorderRadius.circular(14),
          // border: BoxBorder.all(color: context.colors.sky, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
          child: Row(
            children: [
              Image.asset(icon),
              SizedBox(width: 10.w),
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: context.colors.primary,
                    ),
                  ),
                  Text(num),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
