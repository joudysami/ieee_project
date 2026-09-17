import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color textColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.iconColor = const Color(0xFF1E2A45), // dark navy like the mockup
    this.textColor = const Color(0xFF1E2A45),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Icon(icon, size: 22, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}