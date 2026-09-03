abstract class AppString {
  // ======== Splash =======
  static const String branch = "ET5 Student Branch";
  static const String splash = "LEARN. BUILD. GROW.";

  // ==================== Login ====================
  static const String welcome = 'Welcome Back';
  static const String continueToDashboard = 'Log in to continue to your dashboard.';
  static const String email = 'Email Address';
  static const String password = 'Password';
  static const String rememberMe = 'Remember me';
  static const String dontHaveAccount = "Don't have an account?";
  static const String enterYourEmail = 'Enter your email';
  static const String enterYourPassword = 'Enter your password';
  static const String forgetPassword = 'Forget password?';
  static const String login = 'Login';

  // ==================== Validation ====================
  static const String pleaseEnterYourEmail = 'Please enter your email';
  static const String pleaseEnterValidEmail = 'This Email is not valid';
  static const String passwordIsRequired = 'Password is required';
  static const String passwordRequirement =
      'Password must be 8+ chars and 1 uppercase letter';
  static const String registrationPasswordRequirement =
      'Password must contain at least 6 characters, one uppercase letter and one number';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String confirmPasswordIsRequired =
      'Confirm password is required';
  static const String phoneNumberIsRequired = 'Phone number is required';
  static const String validEgyptianPhone =
      'Enter a valid Egyptian phone number';
  static const String resetPasswordRequirement =
      registrationPasswordRequirement;
  static const String onlyLettersNumbersUnderscore =
      'Only letters, numbers and _ are allowed';
  static String fieldIsRequired(String field) => '$field is required';
  static String fieldMinLength(String field, int length) =>
      '$field must be at least $length characters';
  static String fieldNoSpaces(String field) => '$field cannot contain spaces';
}
