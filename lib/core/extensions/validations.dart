abstract class Validations {
  static bool validateEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  static bool validatePassword(String password) {
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{}; revelation:"|,.<>/?])[A-Za-z\d!@#$%^&*()_+\-=\[\]{};:":r"|,.<>/?]{8,}$',
    );

    return passwordRegExp.hasMatch(password);
  }

  static bool validatePhone(String phone) {
    final RegExp phoneRegExp = RegExp(r'^[0-9]{10,15}$');
    return phoneRegExp.hasMatch(phone);
  }
}
