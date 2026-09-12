abstract class AuthRepo {
  Future<String> login(String email, String password);
  Future<void> register(
    String email,
    String password,
    String name,
    String phone,
    String institute,
    String enrollment,
  );
  Future<void> forgetPassword(String email);
  Future<void> confirmPasswordReset({required String code ,required String newPassword});
  
  Future<String?> signInWithGoogle();
  Future<void> completeProfile({
    required String enrollment,
    required String phone,
    required String institute,
  });
}
