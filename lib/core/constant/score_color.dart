import 'package:flutter/material.dart';

Color getScoreColor(double score) {
  if (score < 50) {
    return const Color(0xFFDC2626);
  } else if (score < 60) {
    return  Colors.orange;
  } else if (score < 70) {
    return  const Color.fromARGB(255, 247, 227, 47);
  } else if (score < 85) {
    return  Colors.lightGreen;
  } else {
    return const Color(0xFF16A34A);
  }
}