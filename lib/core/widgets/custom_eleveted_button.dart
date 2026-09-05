import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function()? onTab;
  final Color bgColor;
  final double borderRadius;
  final Color titleColor;

  const CustomElevatedButton({
    super.key,
    required this.title,
    this.onTab,
    required this.bgColor ,
    required this.titleColor ,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {  
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: const BorderSide(width: 1, color: Colors.black)),
      ),
      onPressed: onTab,
      child: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
