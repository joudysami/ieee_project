import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/theme/app_colors.dart';

class CustomeTextformfield extends StatelessWidget {
  final String text;
  final String? hintText;
  final Widget? icon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
   final int? maxLines;
  const CustomeTextformfield({
    super.key,
    required this.text,
    this.hintText,
    this.icon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.minLines,
    this.maxLines=1,
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

        TextSelectionTheme(
          data: TextSelectionThemeData(
          cursorColor: context.colors.sky.shade500,
          selectionHandleColor: context.colors.sky.shade500, 
          selectionColor: context.colors.sky.shade200, 
        ),
          child: TextFormField(
           // cursorColor: context.colors.sky.shade500,
            controller: controller,
            validator: validator,
            minLines: minLines,
            maxLines: maxLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: icon,
              suffixIcon: suffixIcon,
              hintText: hintText,
              prefixIconColor: context.colors.sky.shade500,
              suffixIconColor: context.colors.sky.shade500,
              hintStyle: TextStyle(color: context.colors.grey.shade600),
          
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
        ),
      ],
    );
  }
}
