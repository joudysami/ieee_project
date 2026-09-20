import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';
import 'package:ieee/core/widgets/statistic_style.dart';
import 'package:ieee/core/widgets/sub_sam_card.dart';

import '../../../../core/widgets/main_sam_card.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
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
              AppString.assignment,
              style: TextStyle(
                color: context.colors.primary,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              AppString.viewAndMangeAss,
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
                      head: 'Assignment 1',
                      onMenuTap: () {},
                      child: SubSamCard(
                        statistics: [
                          StatisticItem(
                            title: 'deadline',
                            content: statDate('25 oct' ,color:Color.fromARGB(255, 190, 37, 26)),
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
                            content: statDate('19 oct' ,color: context.colors.sky.shade500),
                          ),
                        ],
                      ),
                    ),
                    // MainSamCard(
                    //   head: 'Assignment 1',
                    //   onMenuTap: () {},
                    //   child: SubSamCard(
                    //     statistics: [
                    //       StatisticItem(
                    //         title: 'deadline',
                    //         content: statText("25 sep"),
                    //       ),
                    //       StatisticItem(
                    //         title: 'link',
                    //         content: statIcon(
                    //           icon: Icons.open_in_new,
                    //           onTap: () {
                    //             // Open session link
                    //           },
                    //         ),
                    //       ),
                    //       StatisticItem(
                    //         title: 'date',
                    //         content: statText("19 sep"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // MainSamCard(
                    //   head: 'Assignment 1',
                    //   onMenuTap: () {},
                    //   child: SubSamCard(
                    //     statistics: [
                    //       StatisticItem(
                    //         title: 'deadline',
                    //         content: statText("25 sep"),
                    //       ),
                    //       StatisticItem(
                    //         title: 'link',
                    //         content: statIcon(
                    //           icon: Icons.open_in_new,
                    //           onTap: () {
                    //             // Open session link
                    //           },
                    //         ),
                    //       ),
                    //       StatisticItem(
                    //         title: 'date',
                    //         content: statText("19 sep"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // MainSamCard(
                    //   head: 'Assignment 1',
                    //   onMenuTap: () {},
                    //   child: SubSamCard(
                    //     statistics: [
                    //       StatisticItem(
                    //         title: 'deadline',
                    //         content: statText("25 sep"),
                    //       ),
                    //       StatisticItem(
                    //         title: 'link',
                    //         content: statIcon(
                    //           icon: Icons.open_in_new,
                    //           onTap: () {
                    //             // Open session link
                    //           },
                    //         ),
                    //       ),
                    //       StatisticItem(
                    //         title: 'date',
                    //         content: statText("19 sep"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // MainSamCard(
                    //   head: 'Assignment 1',
                    //   onMenuTap: () {},
                    //   child: SubSamCard(
                    //     statistics: [
                    //       StatisticItem(
                    //         title: 'deadline',
                    //         content: statText("25 sep"),
                    //       ),
                    //       StatisticItem(
                    //         title: 'link',
                    //         content: statIcon(
                    //           icon: Icons.open_in_new,
                    //           onTap: () {
                    //             // Open session link
                    //           },
                    //         ),
                    //       ),
                    //       StatisticItem(
                    //         title: 'date',
                    //         content: statText("19 sep"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            CustomElevatedButton(
              text: AppString.addNewAss,
              onTap: () => context.push('/addSession'),
              borderRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}