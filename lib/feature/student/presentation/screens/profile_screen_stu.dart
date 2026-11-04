
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/core/helpers/cache_help.dart';
import 'package:ieee/core/storage/secure_storage.dart';
import 'package:ieee/core/widgets/custome_elevateBotton.dart';

class ProfileScreenStu extends StatelessWidget {
  const ProfileScreenStu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Profile Screen Student"),

            SizedBox(height: 30.h),

            CustomElevatedButton(
              width: 310.w,
              text: 'Log Out',
              backgroundColor: const Color(0xFFFEE2E2),
              textColor: const Color(0xFFEF4444),
              
              onTap: () async {
                await CacheHelp.clearSession();
                await SecureStorage.clearBackendToken();

                if (!context.mounted) return;

                context.go('/loginScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
