import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee/core/theme/app_colors.dart';

class CustomDropDownField extends StatelessWidget {
  final String?value;
  final String hint;
  final String label;
  final List<String> items;
  final IconData? icon;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomDropDownField({super.key,
    this.value,
    required this.hint,
    required this.label,
    required this.items,
    this.icon,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
                    value: value,
                    dropdownColor: context.colors.sky.shade50,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: context.colors.sky.shade700,
                      ),
                    ),
                    hint: Text(
                      hint,
                      style: TextStyle(
                        color: context.colors.sky.shade500,
                        fontSize: 14.sp,
                      ),
                    ),
                    decoration: InputDecoration(
                      label: Text(
                        label,
                        style: TextStyle(
                          color: context.colors.sky.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                        ),
                      ),
                      //  icon: Icon(Icons.keyboard_arrow_down),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: context.colors.sky.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: context.colors.sky.shade700,
                          width: 2,
                        ),
                      ),
                    ),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            color: context.colors.sky.shade700,
                            fontSize: 14.sp,
                          ),
                        ),
                      );
                    }).toList(),
                     
                    onChanged: onChanged,
                    validator: validator,
                  );
  }
}