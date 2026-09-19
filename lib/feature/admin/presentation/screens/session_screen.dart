import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 25.w),
                Text(
                  AppString.session,
                  style: TextStyle(
                    color: context.colors.primary,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Text(
              AppString.viewAndMangeSession,
              style: TextStyle(
                color: context.colors.sky.shade700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15.h),
            CustomElevatedButton(
              text: AppString.addNewSession,
              onTap: () => context.push('/addSession'),
              borderRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
