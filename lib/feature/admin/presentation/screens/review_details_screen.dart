import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/padding_ext.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/core/widgets/review_container.dart';

class ReviewDetailsScreen extends StatelessWidget {
  const ReviewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back_ios_outlined),
            ),
            Text(
              AppString.reviewdetails,
              style: TextStyle(
                color: context.colors.primary,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            ReviewContainer(
              studentName: 'Ali',
              assignmentTitle: 'Data Structure',
              submissionDate: '12 oct',
              actionWidget: Container(
                decoration: BoxDecoration(
                  color: context.colors.grey.shade500,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.submissionLink,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: context.colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.link,
                            size: 22.sp,
                            color: context.colors.sky.shade500,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              'github.com/janedoe/ieee-grap',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: context.colors.grey.shade800,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.open_in_new,
                              color: context.colors.grey.shade700,
                            ),
                          ),
                        ],
                      ).setHorizontalPadding(context, 0.01.w),
                    ),
                  ],
                ).setHorizontalAndVerticalPadding(context, 0.04.h, 0.02.w),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colors.grey.shade500),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.description_outlined, size: 20),
                      SizedBox(width: 8.w),
                      Text(
                        'Evaluation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 15, thickness: 0.5),
                  SizedBox(height: 16.h),
                  Text(
                    AppString.adminName,
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colors.sky.shade600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Habiba',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: context.colors.blue.shade500,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  CustomeTextformfield(
                    text: AppString.finalScore,
                    hintText: 'e.g. 95',
                    suffixText: '/100',
                    borderColor: context.colors.grey.shade600,
                  ),
                  SizedBox(height: 12.h),
                  CustomeTextformfield(
                    text: AppString.adminFeedBack,
                    maxLines: 4,
                    minLines: 4,
                    hintText: AppString.provideDetails,
                    borderColor: context.colors.grey.shade600,
                  ),
                ],
              ).setHorizontalAndVerticalPadding(context, 0.04.h, 0.02.w),
            ),
            SizedBox(height: 15.h),
            CustomElevatedButton(
              onTap: () {},
              text: AppString.submitReview,
              height: 40.h,
            ).setHorizontalPadding(context, 0.01.w),
          ],
        ).setHorizontalAndVerticalPadding(context, 0.03.h, 0.03.w),
      ),
    );
  }
}
