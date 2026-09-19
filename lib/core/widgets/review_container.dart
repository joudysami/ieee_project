import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/padding_ext.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';

class ReviewContainer extends StatelessWidget {
  final String studentName;
  final String assignmentTitle;
  final String? submissionDate;
  final VoidCallback? onReviewPressed;
  final Widget? actionWidget;
  const ReviewContainer({
    super.key,
    required this.studentName,
    required this.assignmentTitle,
    this.onReviewPressed,
    this.submissionDate,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.grey.shade100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border(
          top: BorderSide(color: context.colors.sky.shade500, width: 5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppString.submissionDetails,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 15, thickness: 0.5),
          Text(
            AppString.studentName,
            style: TextStyle(fontSize: 16, color: context.colors.sky.shade600),
          ),
          SizedBox(height: 6.h),
          Text(
            studentName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color:context.colors.blue.shade500 ),
          ),
          SizedBox(height: 12.h),
          Text(
            AppString.assName,
            style: TextStyle(fontSize: 16, color: context.colors.sky.shade600),
          ),
          SizedBox(height: 4.h),
          Text(
           assignmentTitle,
            style:  TextStyle(fontWeight: FontWeight.w600, fontSize: 18,color:context.colors.blue.shade500),
          ),
          if (submissionDate != null) ...[
            SizedBox(height: 12.h),
            Text(
              'Submission Date',
              style: TextStyle(fontSize: 16.sp, color:context.colors.sky.shade600),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16.sp,
                  color: context.colors.grey.shade600,
                ),
                SizedBox(width: 6.w),
                Text(
                  submissionDate!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                   color:context.colors.blue.shade500,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 16.h),
          actionWidget??
          CustomElevatedButton(text: AppString.review, onTap:onReviewPressed??(){},height: 40, ),
        ],
      ).setHorizontalAndVerticalPadding(context, 0.05.h, 0.02.w),
    ).setVerticalPadding(context,0.01.h);
  }
}
