import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_string.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/main_sam_card.dart';
import '../../../../core/widgets/statistic_style.dart';
import '../../../../core/widgets/sub_sam_card.dart';

class ManageStudentsScreen extends StatelessWidget {
  const ManageStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppString.manageStudents,
                style: TextStyle(
                  color: context.colors.primary,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppString.viewAndManageStudents,
                style: TextStyle(
                  color: context.colors.sky.shade700,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: SingleChildScrollView(
                  child:Column(
                    children: [
                      MainSamCard(
                        head: 'Ammar belal',
                        onMenuTap: () {},
                        child: SubSamCard(
                          statistics: [
                            StatisticItem(title: 'Score', content: statText("101%")),
                            StatisticItem(title: 'Attendance', content: statText("99%")),
                            StatisticItem(title: 'Points', content: statText("450")),
                          ],
                        ),
                      ),
                      MainSamCard(
                        head: 'Ammar belal',
                        onMenuTap: () {},
                        child: SubSamCard(
                          statistics: [
                            StatisticItem(title: 'Score', content: statText("101%")),
                            StatisticItem(title: 'Attendance', content: statText("99%")),
                            StatisticItem(title: 'Points', content: statText("450")),
                          ],
                        ),
                      ),
                      MainSamCard(
                        head: 'Ammar belal',
                        onMenuTap: () {},
                        child: SubSamCard(
                          statistics: [
                            StatisticItem(title: 'Score', content: statText("101%")),
                            StatisticItem(title: 'Attendance', content: statText("99%")),
                            StatisticItem(title: 'Points', content: statText("450")),
                          ],
                        ),
                      ),
                      MainSamCard(
                        head: 'Ammar belal',
                        onMenuTap: () {},
                        child: SubSamCard(
                          statistics: [
                            StatisticItem(title: 'Score', content: statText("101%")),
                            StatisticItem(title: 'Attendance', content: statText("99%")),
                            StatisticItem(title: 'Points', content: statText("450")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}
