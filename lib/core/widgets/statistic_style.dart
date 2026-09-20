import 'package:flutter/material.dart';

Widget statDate(String value, {Color? color}) {
  return Text(
    value,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: color ?? const Color(0xFF0B101B),
    ),
  );
}

Widget statIcon({required IconData icon, VoidCallback? onTap}) {
  return IconButton(
    onPressed: onTap,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    icon: Icon(icon, size: 24, color: const Color(0xFF73777F)),
  );
}

Widget statText(double value, {String? title, Color? color}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        value.toStringAsFixed(0),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: color ?? const Color(0xFF0B101B),
        ),
      ),

      if (title != null)
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: color ?? const Color(0xFF0B101B),
          ),
        ),
    ],
  );
}
