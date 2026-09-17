import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/constant/app_icons.dart';
import 'package:ieee/core/constant/app_string.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/theme/app_colors.dart';
import 'package:ieee/feature/auth/data/model/user_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final hasSeenSplash = CacheHelp.getSplashSeen();

    if (hasSeenSplash) {
      await Future.delayed(Duration.zero);
      if (!mounted) return;
      _handleNavigation();
      return;
    }
    await CacheHelp.setSplashSeen();
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    _handleNavigation();
  }

  bool _hasNavigated = false;

  Future<void> _handleNavigation() async {
    if (!mounted || _hasNavigated) return;
    _hasNavigated = true;

    final bool isRemembered = CacheHelp.getIsRemembered();
    final UserModel? userData = CacheHelp.getUser();

    log("=== DEBUG CACHE ===");
    log("isRemembered: $isRemembered");
    log("userData null?: ${userData == null}");

    if (isRemembered && userData != null) {
      context.go('/layoutScreen', extra: userData.role);
    } else {
      context.go('/loginScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: context.colors.primary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppIcons.appLogoWhite,
                width: 200.w,
                height: 200.h,
              ),
            ),
            FadeInLeft(
              duration: Duration(seconds: 3),
              child: Text(
                AppString.branch,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: context.colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            FadeInRight(
              duration: Duration(seconds: 3),
              child: Text(
                AppString.splash,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
