import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/app/theme/app_colors.dart';
import 'package:ieee/core/constant/app_icons.dart';
import 'package:ieee/core/widgets/custome_notification.dart';

class StudentHeader extends StatelessWidget {
  final bool showBackButton;
  final String? backLabel;
  final VoidCallback? onBack;

  const StudentHeader({
    super.key,
    this.showBackButton = false,
    this.backLabel,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    if (showBackButton) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onBack ?? () => Navigator.of(context).maybePop(),
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    size: 16.sp,
                    color: context.colors.blue.shade500,
                  ),
                  if (backLabel != null && backLabel!.isNotEmpty) ...[
                    SizedBox(width: 6.w),
                    Text(
                      backLabel!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colors.blue.shade500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Text(
            'IEEE Student Activity',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: context.colors.blue.shade500,
            ),
          ),
          const NotificationBell(count: 0),
        ],
      );
    }

    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: context.colors.sky.shade100,
          backgroundImage: const AssetImage(AppIcons.appLogoWhite),
        ),
        Expanded(
          child: Text(
            'IEEE Student Activity',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: context.colors.blue.shade500,
            ),
          ),
        ),
        const NotificationBell(count: 0),
      ],
    );
  }
}
