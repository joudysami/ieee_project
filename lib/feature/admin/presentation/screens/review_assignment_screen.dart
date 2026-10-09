import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/extensions/padding_ext.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/feature/admin/presentation/manager/admin_cubit.dart';
import '../../../../app/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_textFormField.dart';
import 'package:ieee/core/widgets/review_container.dart';

class ReviewAssignmentScreen extends StatefulWidget {
  const ReviewAssignmentScreen({super.key,});
  @override
  State<ReviewAssignmentScreen> createState() => _ReviewAssignmentScreenState();
}

class _ReviewAssignmentScreenState extends State<ReviewAssignmentScreen> {
 
  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().loadReviewAssignments(CacheHelp.trackId ?? '');
  }

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
            child: BlocBuilder<AdminCubit, AdminState>(
              builder: (context, state) {
                if (state is AdminLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  ); 
                } 
                if (state is AdminError) {
                  return Center(child: Text(state.message));
                } 
                if (state is AdminReviewAssignmentsLoaded) {
                  final reviews = state.reviews;
                  if (reviews.isEmpty) {
                    return const Center(child: Text('No submissions yet'));
                  } 
                  return ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return ReviewContainer(
                        studentName: review.studentName,
                        assignmentTitle: review.assignmentTitle,
                        submissionStatus: review.submissionState,
                        onReviewPressed: () =>
                            context.push('/reviewDetails', extra: review),
                      );
                    }, 
                  ); 
                } 
                return const SizedBox();
              },
            ), 
          ),
        ],
      ).setHorizontalAndVerticalPadding(context, 0.05.h, 0.02.w),
    );
  }
}
