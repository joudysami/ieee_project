import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function()? onTab;
  final Color bgColor;
  final double borderRadius;
  final Color titleColor;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    super.key,
    required this.title,
    this.onTab,
    required this.bgColor,
    required this.titleColor,
    this.borderRadius = 16,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: const BorderSide(width: 1, color: Colors.white),
          ),
        ),
        onPressed: onTab,
        child: Text(title, style: TextStyle(color: titleColor, fontSize: 16)),
      ),
    );
  }
}
