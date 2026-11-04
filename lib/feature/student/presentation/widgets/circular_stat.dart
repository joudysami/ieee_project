import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/app/theme/app_colors.dart';
import 'package:ieee/core/constant/score_color.dart';

class CircularStat extends StatelessWidget {
  final String label;
  final int? percent;
  final String? placeholder;
  final Color? progressColor;

  const CircularStat({
    super.key,
    required this.label,
    this.percent,
    this.placeholder,
    this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = percent != null;
    final value = (percent ?? 0).clamp(0, 100) / 100.0;
    final effectiveColor = progressColor ??
        (hasValue
            ? getScoreColor(percent!.toDouble())
            : context.colors.sky.shade500);

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
                backgroundColor: hasValue
                    ? effectiveColor.withValues(alpha: 0.15)
                    : context.colors.sky.shade100,
                color: effectiveColor,
              ),
              Text(
                hasValue ? '$percent%' : (placeholder ?? '--'),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: hasValue ? effectiveColor : context.colors.blue.shade500,
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
