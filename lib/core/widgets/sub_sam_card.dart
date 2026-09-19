import 'package:flutter/material.dart';

class StatisticItem {
  final String title;
  final Widget content;

  const StatisticItem({required this.title, required this.content});
}

class SubSamCard extends StatelessWidget {
  final List<StatisticItem> statistics;

  const SubSamCard({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFEAECF0)),
      ),
      child: Row(
        children: [
          for (int i = 0; i < statistics.length; i++) ...[
            if (i > 0)
              Container(width: 1, height: 44, color: const Color(0xFFE5E7EB)),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    statistics[i].title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF454951),
                    ),
                  ),

                  const SizedBox(height: 4),

                  statistics[i].content,
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
