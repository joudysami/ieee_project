import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/app/theme/app_colors.dart';
import 'package:ieee/core/models/session_model.dart';
import 'package:ieee/core/models/track_model.dart';
import 'package:ieee/core/widgets/statistic_style.dart';
import 'package:ieee/feature/student/presentation/widgets/student_header.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionDetailsScreen extends StatelessWidget {
  final SessionModel session;
  final TrackModel? track;

  const SessionDetailsScreen({
    super.key,
    required this.session,
    this.track,
  });

  Future<void> _launchUrl(String? rawUrl) async {
    if (rawUrl == null || rawUrl.trim().isEmpty) return;
    final uri = Uri.tryParse(rawUrl.trim());
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final trackName = track?.name ?? 'Track Session';
    final meetingUrl = session.meetingLink ?? track?.meeting;

    return Scaffold(
      backgroundColor: context.colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StudentHeader(
                      showBackButton: true,
                      backLabel: 'Tracks',
                    ),
                    SizedBox(height: 16.h),
                    // Banner Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.colors.blue.shade500,
                            context.colors.primary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: context.colors.blue.shade500.withValues(alpha: 0.25),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Track badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              trackName,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Title
                          Text(
                            session.title ?? 'Session Details',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.25,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          // Metadata Row
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 14.sp,
                                color: context.colors.sky.shade200,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                formatShortDate(session.date),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: context.colors.sky.shade100,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              Icon(
                                Icons.access_time,
                                size: 14.sp,
                                color: context.colors.sky.shade200,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${session.duration} minutes',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: context.colors.sky.shade100,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              Icon(
                                Icons.group_outlined,
                                size: 14.sp,
                                color: context.colors.sky.shade200,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '42 Enrolled',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: context.colors.sky.shade100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // About this Session
                    Text(
                      'About this Session',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: context.colors.blue.shade500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Learn the core concepts, practical techniques, and best practices in this deep-dive workshop. We will explore how to manage state, handle side effects, and build maintainable code in production.',
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
                                  'Dr. Alan Turing',
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
                      onTap: () => _launchUrl(meetingUrl),
                    ),
                    SizedBox(height: 10.h),
                    _ResourceTile(
                      icon: Icons.code,
                      title: 'Code Repository',
                      subtitle: 'GitHub',
                      onTap: () => _launchUrl(meetingUrl),
                    ),
                    if (meetingUrl != null && meetingUrl.isNotEmpty) ...[
                      SizedBox(height: 10.h),
                      _ResourceTile(
                        icon: Icons.link,
                        title: 'Meeting Link',
                        subtitle: 'Online Workspace',
                        onTap: () => _launchUrl(meetingUrl),
                      ),
                    ],
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            // Sticky Join Session Button
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
                    Icons.video_call_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Join Session',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => _launchUrl(meetingUrl),
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
