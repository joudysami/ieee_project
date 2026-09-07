import 'package:go_router/go_router.dart';
import 'package:ieee/app/routes/app_routes_name.dart';
import 'package:ieee/feature/auth/presentation/login/view/login_screen.dart';
import 'package:ieee/feature/splash/splash_screen.dart';

class AppRoutes {

  final GoRouter goRouter = GoRouter(
    initialLocation: AppRoutesName.splashScreen,
    routes: [
      GoRoute(path :'/splashScreen',
       name: AppRoutesName.splashScreen,
        builder: (context, state) => const SplashScreen()),
      GoRoute(path :'/loginScreen',
        name: AppRoutesName.loginScreen,
          builder: (context, state) => const LoginScreen()),
    ],
  );
}