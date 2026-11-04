import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/models/session_model.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import '../../../../app/theme/app_colors.dart';

class UpcomingSessionCard extends StatelessWidget {
  final SessionModel? session;
  final String? meetingFallback;
  final VoidCallback? onJoin;

  const UpcomingSessionCard({
    super.key,
    this.session,
    this.meetingFallback,
    this.onJoin,
  });

  String _formatTime(String? raw) {
    if (raw == null || raw.isEmpty) return '--';
    final d = DateTime.tryParse(raw);
    if (d == null) return raw;
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final period = d.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    if (session == null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.colors.grey.shade500,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          'No upcoming session',
          style: TextStyle(color: context.colors.sky.shade700, fontSize: 14.sp),
        ),
      );
    }

    final s = session!;
    final location = (meetingFallback != null && meetingFallback!.isNotEmpty)
        ? 'Online Workspace'
        : (s.meetingLink != null && s.meetingLink!.isNotEmpty
              ? 'Online Workspace'
              : 'Session');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colors.sky.shade100),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UPCOMING SESSION',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: context.colors.sky.shade500,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatTime(s.date),
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: context.colors.blue.shade500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      s.title ?? 'Session',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colors.blue.shade500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: context.colors.sky.shade600,
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: context.colors.sky.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              CustomElevatedButton(
                text: 'Join Now',
                onTap: onJoin ?? () {},
                width: 100.w,
                height: 36.h,
                fontSize: 12,
                borderRadius: 20,
                backgroundColor: context.colors.sky.shade500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
