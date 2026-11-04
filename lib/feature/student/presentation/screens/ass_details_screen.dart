import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/app/theme/app_colors.dart';
import 'package:ieee/core/models/assignment_model.dart';
import 'package:ieee/core/widgets/statistic_style.dart';
import 'package:ieee/feature/student/data/models/student_submission_model.dart';
import 'package:ieee/feature/student/presentation/widgets/student_header.dart';
import 'package:url_launcher/url_launcher.dart';

class AssDetailsScreen extends StatelessWidget {
  final AssignmentModel assignment;
  final StudentSubmissionModel? submission;

  const AssDetailsScreen({
    super.key,
    required this.assignment,
    this.submission,
  });

  Future<void> _launchUrl(String? rawUrl) async {
    if (rawUrl == null || rawUrl.trim().isEmpty) return;
    final uri = Uri.tryParse(rawUrl.trim());
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final title = assignment.title ?? 'Assignment Details';
    final hasSubmission = submission != null;
    final isReviewed = submission?.score != null;

    return Scaffold(
      backgroundColor: context.colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StudentHeader(
                      showBackButton: true,
                      backLabel: 'Assignments',
                    ),
                    SizedBox(height: 20.h),
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: context.colors.blue.shade500,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Dates row
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14.sp,
                          color: context.colors.sky.shade600,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Assigned: ${formatShortDate(assignment.deadline)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.colors.sky.shade600,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Icon(
                          Icons.event_available_outlined,
                          size: 14.sp,
                          color: context.colors.sky.shade600,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Due: ${formatShortDate(assignment.deadline)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: context.colors.blue.shade500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Score / Submission status banner if present
                    if (isReviewed)
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: context.colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: context.colors.green.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: context.colors.green,
                              size: 22.sp,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                'Reviewed · Grade: ${submission!.score!.toStringAsFixed(0)}/100',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.blue.shade500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (hasSubmission)
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: const Color(0xFFFDE68A)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.hourglass_top,
                              color: Color(0xFFD97706),
                              size: 20,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Submitted · Currently under review',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF92400E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    // About this Assignment
                    Text(
                      'About this Assignments',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: context.colors.blue.shade500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Complete the practical requirements specified in the resources below. Ensure clean modular design, documented architecture, and submit your solution before the final deadline.',
                      style: TextStyle(
                        fontSize: 13.sp,
                        height: 1.5,
                        color: context.colors.sky.shade700,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Instructor Card
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: context.colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: context.colors.sky.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: context.colors.shadow.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: context.colors.sky.shade100,
                            child: Icon(
                              Icons.person,
                              size: 22.sp,
                              color: context.colors.sky.shade700,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. Mona Naiem',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: context.colors.blue.shade500,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Senior Frontend Engineer & Lecturer',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: context.colors.sky.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Resources Section
                    Text(
                      'Resources',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: context.colors.blue.shade500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _ResourceTile(
                      icon: Icons.picture_as_pdf_outlined,
                      title: 'Presentation Slides',
                      subtitle: 'PDF, 2.4 MB',
                      onTap: () => _launchUrl(assignment.assignmentUrl),
                    ),
                    SizedBox(height: 10.h),
                    _ResourceTile(
                      icon: Icons.code,
                      title: 'Code Repository',
                      subtitle: 'GitHub',
                      onTap: () => _launchUrl(assignment.assignmentUrl),
                    ),
                    if (assignment.assignmentUrl.isNotEmpty) ...[
                      SizedBox(height: 10.h),
                      _ResourceTile(
                        icon: Icons.link,
                        title: 'Assignment Link',
                        subtitle: assignment.assignmentUrl,
                        onTap: () => _launchUrl(assignment.assignmentUrl),
                      ),
                    ],
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            // Sticky Submit Button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: context.colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 46.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.sky.shade500,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  icon: const Icon(
                    Icons.upload_file_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    hasSubmission ? 'Resubmit Assignment' : 'Submit Assignment',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _launchUrl(assignment.assignmentUrl),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResourceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ResourceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: context.colors.grey.shade500,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.colors.sky.shade100),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: context.colors.sky.shade50,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: context.colors.sky.shade600,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colors.blue.shade500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: context.colors.sky.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              size: 18.sp,
              color: context.colors.sky.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
