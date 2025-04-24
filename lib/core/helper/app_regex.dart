class AppRegex {
  static bool checkPasswordHasUpperchar(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  static bool checkPasswordHasLowercase(String password) {
    return RegExp(r'[a-z]').hasMatch(password);
  }

  static bool checkPasswordHasSpecialChar(String password) {
    return RegExp(r'[!@#\$&*~%^()_+=\[\]{}|\\:;\"\<>,.?/-]').hasMatch(password);
  }

  static bool checkPasswordHasNumber(String password) {
    return RegExp(r'\d').hasMatch(password);
  }

  static bool checkPasswordHasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  static bool checkEmailText(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool checkPasswordIsStrong(String password) {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>]).{8,}$',
    ).hasMatch(password);
  }
}
