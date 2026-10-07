import 'package:flutter/material.dart';

const _months = [
  'jan',
  'feb',
  'mar',
  'apr',
  'may',
  'jun',
  'jul',
  'aug',
  'sep',
  'oct',
  'nov',
  'dec',
];

// "2026-10-25" -> "25 oct"
// If the text can't be parsed (already formatted, empty, etc.), it is returned as is.
String formatShortDate(String? raw) {
  if (raw == null || raw.isEmpty) return '-';
  final d = DateTime.tryParse(raw);
  if (d == null) return raw;
  return '${d.day} ${_months[d.month - 1]}';
}

Widget statDate(String value, {Color? color}) {
  return Text(
    formatShortDate(value), // CHANGED: parsing happens here
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
