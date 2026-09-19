import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/extensions/extensions.dart';
import 'package:ieee/core/theme/app_colors.dart';
import '../../../../core/helpers/cache_help.dart';
import '../../../../core/widgets/custom_eleveted_button.dart';
import '../../../../core/widgets/setting_tile.dart';
import '../../../auth/data/model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? userData = CacheHelp.getUser();

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 72.h),
          CircleAvatar(
            radius: 50.r,
            backgroundImage: AssetImage(
              "assets/ieee_badge_1C4D8D_transparent.png",
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            userData?.name ?? "",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: context.colors.blue.shade500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            userData?.email ?? "",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Product Designer creating minimal digital systems",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: context.colors.sky.shade600,
              height: 1.4.h,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.sky.shade500,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                icon: Icon(
                  Icons.edit_outlined,
                  color: context.colors.white,
                  size: 18.sp,
                ),
                label: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: context.colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: context.colors.sky.shade500,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.ios_share,
                    size: 20,
                    color: context.colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: context.colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: context.colors.grey.shade50,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsTile(
                  icon: Icons.person_outline,
                  label: "Personal Information",
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 20, endIndent: 20),
                SettingsTile(
                  icon: Icons.notifications_none,
                  label: "Notifications",
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 20, endIndent: 20),
                SettingsTile(
                  icon: Icons.shield_outlined,
                  label: "Security & Privacy",
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 20, endIndent: 20),
                SettingsTile(
                  icon: Icons.help_outline,
                  label: "Help & Support",
                  onTap: () {},
                ),
              ],
            ),

            // Log Out Button
          ),
          SizedBox(height: 48),
          CustomElevatedButton(
            width: 310.w,
            title: 'Log Out',
            bgColor:Color(0xFFFEE2E2),
            titleColor: Color(0xFFEF4444),
            onTab: () async {
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
    ).setHorizontalAndVerticalPadding(context, 0.02, 0.012);
  }
}
