import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class CardMenuItem {
  final String label;
  final IconData? icon;
  final Color? color;
  final VoidCallback onTap;

  const CardMenuItem({
    required this.label,
    required this.onTap,
    this.icon,
    this.color,
  });
}

class MainSamCard extends StatelessWidget {
  final String head;
  final Function()? onMenuTap;
  final List<CardMenuItem>? menuItems;
  final Widget child;

  const MainSamCard({
    super.key,
    required this.head,
    this.onMenuTap,
    required this.child,
    this.menuItems,
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
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: context.colors.blue.shade500,
                  ),
                ),
              ),
              menuItems != null
                  ? PopupMenuButton<int>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Color(0xFF73777F),
                        size: 30,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (i) => menuItems![i].onTap(),
                      itemBuilder: (_) => [
                        for (int i = 0; i < menuItems!.length; i++)
                          PopupMenuItem<int>(
                            value: i,
                            child: Row(
                              children: [
                                if (menuItems![i].icon != null) ...[
                                  Icon(
                                    menuItems![i].icon,
                                    size: 20,
                                    color: menuItems![i].color,
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                Text(
                                  menuItems![i].label,
                                  style: TextStyle(color: menuItems![i].color),
                                ),
                              ],
                            ),
                          ),
                      ],
                    )
                  : IconButton(
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
