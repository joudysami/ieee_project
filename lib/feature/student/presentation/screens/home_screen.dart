import 'package:flutter/material.dart';
import 'package:ieee/core/theme/app_colors.dart';

class HomeScreenStu extends StatelessWidget {
  const HomeScreenStu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text(
          "im studenttttt",
          style: TextStyle(
            fontSize: 24,
            color: context.colors.primary
          ) ,
        ),
      ),
    );
  }
}
