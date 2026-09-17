import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_icons.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 350.w,
                  height: 290.h,
                  decoration: BoxDecoration(
                    color: context.colors.grey.shade500,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.assignment,
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: context.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
            
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.asset(
                            AppIcons.assignment,
                            width: 350.w,
                            height: 160.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomElevatedButton(
                          text: AppString.newAssignment,
                          onTap: () => context.push('/addAssignment'),
                          height: 32.h,
                          width: 180.w,
                          icon: Icon(Icons.add, color: context.colors.white),
                          fontSize: 14,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            CustomElevatedButton(
                              text: AppString.veiwAll,
                              onTap: () => context.go('/assignment'),
                              height: 32.h,
                              width: 90.w,
                              fontSize: 14,
                            ),
                            SizedBox(width: 10.w),
                            CustomElevatedButton(
                              text: AppString.review,
                              height: 32.h,
                              width: 90.w,
                              onTap: () => context.go('/reviewAssignment'),
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  width: 350.w,
                  height: 260.h,
                  decoration: BoxDecoration(
                    color: context.colors.grey.shade500,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.session,
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: context.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
            
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.asset(
                            AppIcons.session,
                            width: 350.w,
                            height: 160.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            CustomElevatedButton(
                              text: AppString.newSession,
                              onTap: () => context.push('/addSession'),
                              height: 32.h,
                              width: 170.w,
                              icon: Icon(Icons.add, color: context.colors.white),
                              fontSize: 14,
                            ),
                            SizedBox(width: 10.w),
                            CustomElevatedButton(
                              text: AppString.veiwAll,
                              onTap: () => context.go('/session'),
                              height: 32.h,
                              width: 90.w,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
