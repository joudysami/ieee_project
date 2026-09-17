import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/theme/app_colors.dart';

class NotificationBell extends StatelessWidget {
  final int count;

  const NotificationBell({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.notifications_none_rounded,
          size: 28.w,
          color: context.colors.primary,
        ),

        if (count > 0)
          Positioned(
            top: -5.h,
            right: -5.w,
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5.w),
              ),
              constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),

              child: Text(
                count > 9 ? '9+' : '$count',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
