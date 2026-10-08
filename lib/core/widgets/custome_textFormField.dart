import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/theme/app_colors.dart';

class CustomeTextformfield extends StatefulWidget {
  final String text;
  final String? suffixText;
  final String? hintText;
  final Widget? icon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int? maxLines;
  final Color? borderColor;
  final bool isPassword;

  const CustomeTextformfield({
    super.key,
    required this.text,
    this.hintText,
    this.icon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.minLines,
    this.borderColor,
    this.maxLines = 1,
    this.suffixText,
    this.isPassword = false,
  });

  @override
  State<CustomeTextformfield> createState() => _CustomeTextformfieldState();
}

class _CustomeTextformfieldState extends State<CustomeTextformfield> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor =
        widget.borderColor ?? context.colors.sky.shade400;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
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
            controller: widget.controller,
            validator: widget.validator,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            obscureText: widget.isPassword && _obscure,
            enableSuggestions: !widget.isPassword,
            autocorrect: !widget.isPassword,
            keyboardType: widget.isPassword
                ? TextInputType.visiblePassword
                : null,

            decoration: InputDecoration(
              prefixIcon: widget.icon,
              suffixIcon:
                  widget
                      .isPassword // NEW: show/hide button
                  ? IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    )
                  : null,

              hintText: widget.hintText,
              suffixText: widget.suffixText,
              prefixIconColor: context.colors.sky.shade500,
              suffixIconColor: context.colors.sky.shade500,
              hintStyle: TextStyle(color: context.colors.grey.shade800),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: effectiveBorderColor),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: effectiveBorderColor),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: effectiveBorderColor, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
