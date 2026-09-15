import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/app/routes/app_routes_name.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:ieee/feature/auth/presentation/screens/complete_profile_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/forget_password_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/login_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/register_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/reset_password_screen.dart';
import 'package:ieee/feature/splash/splash_screen.dart';

import '../../feature/admin/presentation/screens/home_screen.dart';
import '../../feature/layout/layout_screen.dart';
import '../../feature/student/presentation/screens/home_screen.dart';

class AppRoutes {
  final GoRouter goRouter = GoRouter(
    initialLocation: AppRoutesName.splashScreen,
    routes: [
      GoRoute(
        path: '/splashScreen',
        name: AppRoutesName.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/loginScreen',
        name: AppRoutesName.loginScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),

      GoRoute(
        path: '/registerScreen',
        name: AppRoutesName.registerScreen,
        builder: (context, state) {
         
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: const RegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: '/forgotPasswordScreen',
        name: AppRoutesName.forgotPasswordScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: '/adminScreen',
        name: AppRoutesName.adminScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/studentScreen',
        name: AppRoutesName.studentScreen,
        builder: (context, state) => const HomeScreenStu(),
      ),
      GoRoute(
        path: '/layoutScreen',
        name: AppRoutesName.layoutScreen,
        builder: (context, state) {
          final role = state.extra as String?;
          return LayoutScreen(role: role);
        },
      ),

      GoRoute(
        path: '/completeProfileScreen',
        name: AppRoutesName.completeProfileScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const CompleteProfileScreen(),
        ),
      ),

      GoRoute(
        path: '/__/auth/links',
        name: AppRoutesName.resetPasswordScreen,
        builder: (context, state) {
          String oobCode = state.uri.queryParameters['oobCode'] ?? '';
        if (oobCode.isEmpty) {
      final nestedLink = state.uri.queryParameters['link'];
      if (nestedLink != null) {
        final innerUri = Uri.parse(nestedLink);
        oobCode = innerUri.queryParameters['oobCode'] ?? '';
      }
    }
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: ResetPasswordScreen(oobCode: oobCode),
          );
        },
      ),
    ],
  );
}
