import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback onTap;
  final AppStates? loadingState;      
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final double fontSize;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.loadingState,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    
    final effectiveBgColor = backgroundColor ?? context.colors.sky.shade500;
    final effectiveTextColor = textColor ?? context.colors.white;

    return SizedBox(
      width: width ?? double.infinity,        
      height: height,
      child: BlocBuilder<AuthCubit, AppStates>(
        buildWhen: (previous, current) {
          if (loadingState == null) return false;
          return (previous == loadingState) != (current == loadingState);
        },
        builder: (context, state) {
          final isLoading = loadingState != null && state == loadingState;

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: effectiveBgColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius.r),
                side: borderColor != null
                    ? BorderSide(color: borderColor!, width: 1.w)
                    : BorderSide.none,
              ),
              padding: EdgeInsets.symmetric(
                vertical: height == null ? 14.h : 0,
                horizontal: 16.w,
              ),
            ),
            onPressed: isLoading ? null : onTap,
            child: isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      color: effectiveTextColor,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        icon!,
                        SizedBox(width: 4.w),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize.sp,
                          fontWeight: FontWeight.bold,
                          color: effectiveTextColor,
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}