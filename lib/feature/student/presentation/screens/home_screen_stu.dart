import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/theme/app_colors.dart';

import '../../../../core/helpers/cache_help.dart';

class HomeScreenStu extends StatelessWidget {
  const HomeScreenStu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "im studenttttt",
              style: TextStyle(fontSize: 24, color: context.colors.primary),
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
  }
}
