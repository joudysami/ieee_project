import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/theme/app_colors.dart';

class CustomeTextformfield extends StatelessWidget {
  final String text;
  final String? hintText;
  final Widget? icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomeTextformfield({
    super.key,
    required this.text,
    this.hintText,
    this.icon,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: context.colors.sky.shade700,
          ),
        ),
        SizedBox(height: 2.h),
        TextFormField(
          cursorColor: context.colors.sky.shade500,
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hintText,
            prefixIconColor: context.colors.sky.shade500,
            hintStyle: TextStyle(color: context.colors.sky.shade500),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: context.colors.sky.shade400),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: context.colors.sky.shade400),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: context.colors.sky.shade700,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
