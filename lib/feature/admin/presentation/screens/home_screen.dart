import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_icons.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/core/widgets/custome_notification.dart';
import 'package:ieee/core/widgets/home_Continer.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/data/model/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AppStates>(
        builder: (context, state) {
          final UserModel? userData = CacheHelp.getUser();

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          AppString.goodMorning,
                          style: TextStyle(
                            color: context.colors.blue.shade500,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            userData?.name ?? '',
                            style: TextStyle(
                              color: context.colors.blue.shade500,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      AppString.happingInYourBransh,
                      style: TextStyle(color: context.colors.primary),
                    ),
                    SizedBox(height: 8),
                    HomeContiner(
                      title: AppString.totalStudent,
                      icon: AppIcons.totalStudent,
                      num: '??',
                    ),
                    HomeContiner(
                      title: AppString.totalSission,
                      icon: AppIcons.totalSession,
                      num: '??',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 350.w,
                        height: 250.h,
                        decoration: BoxDecoration(
                          color: context.colors.grey.shade500,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppString.pendingReview,
                                      style: TextStyle(
                                        color: context.colors.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    NotificationBell(count: 5),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size.zero,
                                          // tapTargetSize:
                                          //     MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        onPressed:()=>context.go('/reviewAssignment'),
                                        child: Text(
                                          AppString.veiwAll,
                                          style: TextStyle(
                                            color: context.colors.sky.shade500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 350.w,
                        height: 220.h,
                        decoration: BoxDecoration(
                          color: context.colors.grey.shade500,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 14.h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.recentActivity,
                                style: TextStyle(
                                  color: context.colors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}