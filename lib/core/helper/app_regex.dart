class AppRegex {
  static final RegExp name = RegExp(r"^[a-zA-Z\s]{2,}$");
  static final RegExp email = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final RegExp password =
      RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

  static String? passwordValidator(String? value) {
    List<String> errors = [];

    if (value == null || value.isEmpty) {
      errors.add('Password is required');
    }
    if (value!.length < 8) {
      errors.add('At least 8 characters');
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      errors.add('At least one uppercase letter');
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      errors.add('At least one number');
    }
    if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
      errors.add('At least one special character (@\$!%*?&)');
    }

    return errors.isNotEmpty ? errors.join('\n') : null;
  }
}
