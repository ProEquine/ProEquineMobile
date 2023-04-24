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
    if (value != null ) {
      if (!RegExp(
        r"(?:[ +0][1-9])?",
      ).hasMatch(value.trim())) {
        return 'Please enter a valid phone number'.tra;
      }
      if(value.isEmpty){
        return 'Please enter a valid phone number'.tra;
      }
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'This field is required'.tra;
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.trim())) {
      return 'Please enter a valid email address'.tra;
    }
    return null;
  }
  static String? passwordValidator(String? value) {
    if (value == null) {
      return 'Please enter your password'.tra;
    }

    if (value.trim().isEmpty) {
      return 'Please enter your password'.tra;
    }
    if (value.length < 5) {
      return 'Must contain at least 5 or more characters'.tra;
    }
    return null;
  }
}
