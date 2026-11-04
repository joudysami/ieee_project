import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/app/theme/app_colors.dart';

class SegmentedProgressBar extends StatelessWidget {
  final int totalSegments;
  final int completedSegments;
  final Color? activeColor;
  final Color? inactiveColor;
  final double height;

  const SegmentedProgressBar({
    super.key,
    required this.totalSegments,
    required this.completedSegments,
    this.activeColor,
    this.inactiveColor,
    this.height = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? context.colors.sky.shade500;
    final effectiveInactiveColor =
        inactiveColor ?? context.colors.sky.shade100;
    final count = totalSegments.clamp(1, 30);
    final completed = completedSegments.clamp(0, count);

    return Row(
      children: List.generate(count, (index) {
        final isFilled = index < completed;
        return Expanded(
          child: Container(
            height: height.h,
            margin: EdgeInsets.symmetric(horizontal: 1.5.w),
            decoration: BoxDecoration(
              color: isFilled ? effectiveActiveColor : effectiveInactiveColor,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
        );
      }),
    );
  }
}
