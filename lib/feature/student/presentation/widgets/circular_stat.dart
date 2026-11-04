import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/theme/app_colors.dart';

class CircularStat extends StatelessWidget {
  final String label;
  final int? percent;
  final String? placeholder;

  const CircularStat({
    super.key,
    required this.label,
    this.percent,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = percent != null;
    final value = (percent ?? 0).clamp(0, 100) / 100.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 72.w,
          height: 72.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: hasValue ? value : 0,
                strokeWidth: 7,
                backgroundColor: context.colors.sky.shade100,
                color: context.colors.sky.shade500,
              ),
              Text(
                hasValue ? '$percent%' : (placeholder ?? '--'),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: context.colors.blue.shade500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.blue.shade500,
          ),
        ),
      ],
    );
  }
}
