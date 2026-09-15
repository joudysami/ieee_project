import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AssignmentsScreenStu extends StatelessWidget {
  const AssignmentsScreenStu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text(
          "im studenttttt Ass",
          style: TextStyle(
              fontSize: 24,
              color: context.colors.primary
          ) ,
        ),
      ),
    );
  }
}
