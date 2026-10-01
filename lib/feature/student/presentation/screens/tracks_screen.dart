import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class TracksScreenStu extends StatelessWidget {
  const TracksScreenStu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text(
          "im studenttttt Track",
          style: TextStyle(
              fontSize: 24,
              color: context.colors.primary
          ) ,
        ),
      ),
    );
  }
}
