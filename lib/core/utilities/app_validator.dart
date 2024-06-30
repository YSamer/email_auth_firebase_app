class AppValidator {
  static String? emailValidate(String? value) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? passwordValidate(String? value, {String? password}) {
    if (value == null || value.length < 6) {
      return 'Please enter correct password';
    } else if (password != null && value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
