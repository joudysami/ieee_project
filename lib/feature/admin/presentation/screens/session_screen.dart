import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/main_sam_card.dart';
import '../../../../core/widgets/statistic_style.dart';
import '../../../../core/widgets/sub_sam_card.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back_ios_outlined),
            ),
            Text(
              AppString.session,
              style: TextStyle(
                color: context.colors.primary,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppString.viewAndMangeSession,
              style: TextStyle(
                color: context.colors.sky.shade700,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MainSamCard(
                      head: 'Session 1',
                      onMenuTap: () {},
                      child: SubSamCard(
                        statistics: [
                          StatisticItem(
                            title: 'duration',
                            content: statText('90 min'),
                          ),
                          StatisticItem(
                            title: 'link',
                            content: statIcon(
                              icon: Icons.open_in_new,
                              onTap: () {
                                // Open session link
                              },
                            ),
                          ),
                          StatisticItem(
                            title: 'date',
                            content: statText('25 oct'),
                          ),
                        ],
                      ),
                    ),
                    MainSamCard(
                      head: 'Session 1',
                      onMenuTap: () {},
                      child: SubSamCard(
                        statistics: [
                          StatisticItem(
                            title: 'duration',
                            content: statText('90 min'),
                          ),
                          StatisticItem(
                            title: 'link',
                            content: statIcon(
                              icon: Icons.open_in_new,
                              onTap: () {
                                // Open session link
                              },
                            ),
                          ),
                          StatisticItem(
                            title: 'date',
                            content: statText('25 oct'),
                          ),
                        ],
                      ),
                    ),
                    MainSamCard(
                      head: 'Session 1',
                      onMenuTap: () {},
                      child: SubSamCard(
                        statistics: [
                          StatisticItem(
                            title: 'duration',
                            content: statText('90 min'),
                          ),
                          StatisticItem(
                            title: 'link',
                            content: statIcon(
                              icon: Icons.open_in_new,
                              onTap: () {
                                // Open session link
                              },
                            ),
                          ),
                          StatisticItem(
                            title: 'date',
                            content: statText('25 oct'),
                          ),
                        ],
                      ),
                    ),
                    MainSamCard(
                      head: 'Session 1',
                      onMenuTap: () {},
                      child: SubSamCard(
                        statistics: [
                          StatisticItem(
                            title: 'duration',
                            content: statText('90 min'),
                          ),
                          StatisticItem(
                            title: 'link',
                            content: statIcon(
                              icon: Icons.open_in_new,
                              onTap: () {
                                // Open session link
                              },
                            ),
                          ),
                          StatisticItem(
                            title: 'date',
                            content: statText('25 oct'),
                          ),
                        ],
                      ),
                    ),
                    MainSamCard(
                      head: 'Session 1',
                      onMenuTap: () {},
                      child: SubSamCard(
                        statistics: [
                          StatisticItem(
                            title: 'duration',
                            content: statText('90 min'),
                          ),
                          StatisticItem(
                            title: 'link',
                            content: statIcon(
                              icon: Icons.open_in_new,
                              onTap: () {
                                // Open session link
                              },
                            ),
                          ),
                          StatisticItem(
                            title: 'date',
                            content: statText('25 oct'),
                          ),
                        ],
                      ),
                    ),
                    MainSamCard(
                      head: 'Session 1',
                      onMenuTap: () {},
                      child: SubSamCard(
                        statistics: [
                          StatisticItem(
                            title: 'duration',
                            content: statText('90 min'),
                          ),
                          StatisticItem(
                            title: 'link',
                            content: statIcon(
                              icon: Icons.open_in_new,
                              onTap: () {
                                // Open session link
                              },
                            ),
                          ),
                          StatisticItem(
                            title: 'date',
                            content: statText('25 oct'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            CustomElevatedButton(
              text: AppString.addNewSession,
              onTap: () => context.push('/addSession'),
              borderRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
