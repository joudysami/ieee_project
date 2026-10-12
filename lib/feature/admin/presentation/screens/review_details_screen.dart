import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/padding_ext.dart';
import 'package:ieee/core/extensions/validations.dart';
import 'package:ieee/feature/admin/data/models/add_score_model.dart';
import 'package:ieee/feature/admin/data/models/review_ass_model.dart';
import 'package:ieee/feature/admin/presentation/manager/admin_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/core/widgets/review_container.dart';

import '../../../../core/helpers/cache_help.dart';
import '../../../auth/data/model/user_model.dart';

class ReviewDetailsScreen extends StatefulWidget {
  final ReviewAssignmentModel review;
  const ReviewDetailsScreen({super.key, required this.review});

  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _scoreController;
  late final TextEditingController _feedbackController;

  void _saveScore() {
    if (!_formKey.currentState!.validate()) return;
    final UserModel? userData = CacheHelp.getUser();
    final feedbackDate = DateTime.now();
    final score = int.tryParse(_scoreController.text.trim());
    final feedback = _feedbackController.text.trim();

    if (score == null || score < 0 || score > 100) {
      return;
    }

    context.read<AdminCubit>().addFeedback(
      AddScore(
        submissionId: widget.review.submissionId,
        nameOfReviwer: userData?.uId ?? '',
        score: score,
        feedback: feedback,
        submissionDate: feedbackDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? userData = CacheHelp.getUser();

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
              studentName: widget.review.studentName,
              assignmentTitle: widget.review.assignmentTitle,
              submissionStatus: widget.review.submissionState,
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
                              widget.review.submissionUrl,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: context.colors.grey.shade800,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (widget.review.submissionUrl.isNotEmpty) {
                                launchUrl(
                                  Uri.parse(widget.review.submissionUrl),
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
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
              child: Form(
                key: _formKey,
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
                      userData?.name ?? '',
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
                      controller: _scoreController,
                      validator: (value) => Validations.validateRequired(
                        value,
                        AppString.finalScore,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CustomeTextformfield(
                      text: AppString.adminFeedBack,
                      maxLines: 4,
                      minLines: 4,
                      hintText: AppString.provideDetails,
                      borderColor: context.colors.grey.shade600,
                      controller: _feedbackController,
                      validator: (value) => Validations.validateRequired(
                        value,
                        AppString.adminFeedBack,
                      ),
                    ),
                  ],
                ).setHorizontalAndVerticalPadding(context, 0.04.h, 0.02.w),
              ),
            ),
            SizedBox(height: 15.h),
            CustomElevatedButton(
              onTap: _saveScore,
              text: AppString.submitReview,
              height: 40.h,
            ).setHorizontalPadding(context, 0.01.w),
          ],
        ).setHorizontalAndVerticalPadding(context, 0.03.h, 0.03.w),
      ),
    );
  }
}
