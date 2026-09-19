import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ieee/app/routes/app_routes_name.dart';
import 'package:ieee/feature/admin/presentation/screens/add_assignment_screen.dart';
import 'package:ieee/feature/admin/presentation/screens/add_session_screen.dart';
import 'package:ieee/feature/admin/presentation/screens/assignment_screen.dart';
import 'package:ieee/feature/admin/presentation/screens/review_assignment_screen.dart';
import 'package:ieee/feature/admin/presentation/screens/review_details_screen.dart';
import 'package:ieee/feature/admin/presentation/screens/session_screen.dart';
import 'package:ieee/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:ieee/feature/auth/presentation/screens/complete_profile_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/forget_password_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/login_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/register_screen.dart';
import 'package:ieee/feature/auth/presentation/screens/reset_password_screen.dart';
import 'package:ieee/feature/splash/splash_screen.dart';
import '../../feature/admin/presentation/screens/home_screen.dart';
import '../../feature/admin/presentation/screens/track_screen.dart';
import '../../feature/layout/layout_screen.dart';
import '../../feature/student/presentation/screens/home_screen_stu.dart';

class AppRoutes {
  static final AuthCubit _authCubit = AuthCubit();

  final GoRouter goRouter = GoRouter(
    initialLocation: AppRoutesName.splashScreen,
    routes: [
      GoRoute(
        path: '/splashScreen',
        name: AppRoutesName.splashScreen,
        builder: (context, state) =>
            BlocProvider.value(value: _authCubit, child: const SplashScreen()),
      ),
      GoRoute(
        path: '/loginScreen',
        name: AppRoutesName.loginScreen,
        builder: (context, state) =>
            BlocProvider.value(value: _authCubit, child: const LoginScreen()),
      ),

      GoRoute(
        path: '/registerScreen',
        name: AppRoutesName.registerScreen,
        builder: (context, state) {
          return BlocProvider.value(
            value: _authCubit,
            child: const RegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: '/forgotPasswordScreen',
        name: AppRoutesName.forgotPasswordScreen,
        builder: (context, state) => BlocProvider.value(
          value: _authCubit,
          child: const ForgotPasswordScreen(),
        ),
      ),

      GoRoute(
        path: '/completeProfileScreen',
        name: AppRoutesName.completeProfileScreen,
        builder: (context, state) => BlocProvider.value(
          value: _authCubit,
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
          return BlocProvider.value(
            value: _authCubit,
            child: ResetPasswordScreen(oobCode: oobCode),
          );
        },
      ),
      GoRoute(
        path: '/layoutScreen',
        name: AppRoutesName.layoutScreen,
        builder: (context, state) {
          final role = state.extra as String?;
          return BlocProvider.value(
            value: _authCubit,
            child: LayoutScreen(role: role),
          );
        },
      ),

      GoRoute(
        path: '/adminScreen',
        name: AppRoutesName.adminScreen,
        builder: (context, state) =>
            BlocProvider.value(value: _authCubit, child: const HomeScreen()),
      ),

      GoRoute(
        path: '/trackScreen',
        name: AppRoutesName.trackScreen,
        builder: (context, state) =>
            BlocProvider.value(value: _authCubit, child: const TrackScreen()),
      ),

      GoRoute(
        path: '/studentScreen',
        name: AppRoutesName.studentScreen,
        builder: (context, state) => const HomeScreenStu(),
      ),
      GoRoute(
        path: '/reviewAssignment',
        name: AppRoutesName.reviewAss,
        builder: (context, state) => BlocProvider.value(
          value: _authCubit,
          child: const ReviewAssignmentScreen(),
        ),
      ),
      GoRoute(
        path: '/session',
        name: AppRoutesName.session,
        builder: (context, state) =>
            BlocProvider.value(value: _authCubit, child: const SessionScreen()),
      ),
      GoRoute(
        path: '/addSession',
        name: AppRoutesName.addSession,
        builder: (context, state) => BlocProvider.value(
          value: _authCubit,
          child: const AddSessionScreen(),
        ),
      ),
      GoRoute(
        path: '/assignment',
        name: AppRoutesName.assignment,
        builder: (context, state) => BlocProvider.value(
          value: _authCubit,
          child: const AssignmentScreen(),
        ),
      ),
      GoRoute(
        path: '/addAssignment',
        name: AppRoutesName.addAssignment,
        builder: (context, state) => BlocProvider.value(
          value: _authCubit,
          child: const AddAssignmentScreen(),
        ),
      ),
      GoRoute(
        path: '/reviewDetails',
        name: AppRoutesName.reviewDetails,
        builder: (context, state) => BlocProvider.value(
          value: _authCubit,
          child: const ReviewDetailsScreen(),
        ),
      )
    ],
  );
}
