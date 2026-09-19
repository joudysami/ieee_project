import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/padding_ext.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/core/widgets/review_container.dart';

class ReviewAssignmentScreen extends StatelessWidget {
  const ReviewAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_ios_outlined),
          ),
          SizedBox(width: 25.w),
          Text(
            AppString.reviewAss,
            style: TextStyle(
              color: context.colors.primary,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomeTextformfield(
            text: '',
            hintText: AppString.searchByName,
            icon: Icon(Icons.search, color: context.colors.grey.shade600),
            borderColor: context.colors.grey.shade600,
          ),
          SizedBox(height: 12.h),

          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReviewContainer(
                  studentName: 'Ali',
                  assignmentTitle: 'Data Structure',
                  onReviewPressed: () => context.push('/reviewDetails'),
                );
              },
            ),
          ),
        ],
      ).setHorizontalAndVerticalPadding(context, 0.05.h, 0.02.w),
    );
  }
}
