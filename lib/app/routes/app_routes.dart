import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/app/routes/app_routes_name.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:ieee/feature/auth/presentation/screens/complete_profile_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/forget_password_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/admin_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/login_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/register_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/student_screen.dart';
import 'package:ieee/feature/splash/splash_screen.dart';

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
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: '/forgotPasswordScreen',
        name: AppRoutesName.forgotPasswordScreen,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/adminScreen',
        name: AppRoutesName.adminScreen,
        builder: (context, state) => const AdminScreen(),
      ),
      GoRoute(
        path: '/studentScreen',
        name: AppRoutesName.studentScreen,
        builder: (context, state) => const StudentScreen(),
      ),
      GoRoute(
        path: '/completeProfileScreen',
        name: AppRoutesName.completeProfileScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),

          child: const CompleteProfileScreen(),
        ),
      ),
    ],
  );
}
