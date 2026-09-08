import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';

class CustomeElevatebotton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback onTap;
  final AppStates loadingState;
  const CustomeElevatebotton({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    required this.loadingState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340.w,
      child: BlocBuilder<AuthCubit, AppStates>(
        buildWhen: (previous, current) {
          return (previous == loadingState) !=
              (current == loadingState);
        },
        builder: (context, state) {
          final isLoading = state == loadingState;
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: onTap,
            child: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: (isLoading)
                  ? CircularProgressIndicator(color: context.colors.white)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: context.colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        if (icon != null) ...[icon!, SizedBox(width: 8.w)],
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
