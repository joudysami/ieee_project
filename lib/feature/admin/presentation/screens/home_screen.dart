import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/states/app_states.dart';
import 'package:ieee/core/theme/app_colors.dart';
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppString.goodMorning,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(userData?.name ?? ''),
                    ],
                  ),

                  IconButton(
                    icon: Icon(Icons.logout, color: context.colors.error),
                    tooltip: 'Sign Out',
                    onPressed: () async {
                      // 1. مسح البيانات المحفوظة في SharedPreferences
                      await CacheHelp.clearSession();

                      // 2. استدعاء دالة الخروج من AuthCubit
                      if (context.mounted) {
                        // await context.read<AuthCubit>().signOut(); // أو اسم دالة SignOut لديكِ

                        if (!context.mounted) return;

                        // 3. التوجيه لشاشة اللوجين ومسح جميع الشاشات الـ Stack
                        context.go('/loginScreen');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
