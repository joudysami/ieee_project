import 'package:flutter/material.dart';
import 'package:ieee/core/theme/app_colors.dart';

class MainSamCard extends StatelessWidget {
  final String head;
  final Function() onMenuTap;
  final Widget child;

  const MainSamCard({
    super.key,
    required this.head,
    required this.onMenuTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Student name and menu
          Row(
            children: [
              Expanded(
                child: Text(
                  head,
                  style:  TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color:context.colors.blue.shade500 ,
                  ),
                ),
              ),
              IconButton(
                onPressed: onMenuTap,
                icon: const Icon(
                  Icons.more_vert,
                  color: Color(0xFF73777F),
                  size: 30,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
