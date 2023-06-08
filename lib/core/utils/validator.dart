import 'package:proequine/core/utils/extensions.dart';

class Validator {
  String? password;
  static String? requiredValidator(String? value) {
    if (value == null) {
      return 'This field is required'.tra;
    }

    if (value == 'null') {
      return 'This field is required'.tra;
    }
    if (value.trim().isEmpty) {
      return 'This field is required'.tra;
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value != null) {
      if (value.startsWith('0')) {
        return 'Number should not start with zero';
      }
      if (!RegExp(
        r'(^(?:[+0]9)?[0-9]{8,12}$)',
      ).hasMatch(value.trim())) {
        return 'Please enter a valid phone number'.tra;
      }
      if (value.isEmpty) {
        return 'Please enter a valid phone number'.tra;
      }
    }
    return null;
  }

  static String? countryCodeValidator(String? value) {
    if (value != null) {
      if (!RegExp(
        r'^\+(?:[0-9] ?){0,2}[0-9]$',
      ).hasMatch(value.trim())) {
        return 'Please enter a valid phone number'.tra;
      }
      if (value.isEmpty) {
        return 'Please enter a valid phone number'.tra;
      }
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'This field is required'.tra;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value.trim())) {
      return 'Please enter a valid email address'.tra;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value != null) {
      if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
          .hasMatch(value.trim())) {
        return 'Password must include numbers, capital letters, and symbols.'
            .tra;
      }
      if (value.isEmpty) {
        return 'Please enter your password'.tra;
      }
    }
    return null;
  }
}
