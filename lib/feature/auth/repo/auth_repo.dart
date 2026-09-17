import 'package:ieee/feature/auth/data/model/user_model.dart';

abstract class AuthRepo {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(
    String email,
    String password,
    String name,
    String phone,
    String institute,
    String enrollment,
  );
  Future<void> forgetPassword(String email);
  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  });

  Future<UserModel?> signInWithGoogle();
  Future<UserModel> completeProfile({
    required String enrollment,
    required String phone,
    required String institute,
  });
}
