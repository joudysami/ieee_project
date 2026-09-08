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
  static const String loginWithGoogle = 'Login with Google';
  static const String save='Save';
  static const String complete='Complete Data';
 // ==================== Register ====================
  static const String name = 'Full Name';
  static const String phoneNumber = 'Phone Number';
  static const String confirmPassword = 'Confirm Password';
  static const String enrollment = 'Enrollment ';
  static const String institue = 'Institute';
  static const String adminCode = 'Admin Code';
  static const String createAccount = 'Create Account';
  static const String joinAcadimic = 'Join the academic tech community.';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String enterName = 'Enter your name';
  static const String pleaseEnterName = 'Please enter your name';
  static const String pleaseEnterValidPassword = 'Please enter a valid password';
  static const String selectRole = 'Please select a role';
  static const String selectInstitute = 'Please select your institute';
  static const String continueGoogle = 'Continue with Google';
  static const String selectRollAndInstitute = 'Please select your Phone, Role and Institute';
  // ==================== Validation ====================
  static const String pleaseEnterValidEmail = 'Please enter a valid email address';
  static const String pleaseEnterYourEmail = 'Please enter your email';
  static const String notValidEmail = 'This Email is not valid';
  static const String passwordIsRequired = 'Password is required';
  
  static const String passwordRequirement =
      'Password must be 8+ chars and 1 uppercase letter';
  static const String registrationPasswordRequirement =
      'Password must be at least 8 characters long, and contain a letter, a number, and a special character (e.g. # @ ! \$)';
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
