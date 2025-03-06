// ignore_for_file: constant_identifier_names

abstract class ValidatorUtils {
  static String? validateEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return 'Campo Requierido';
    } else {
      return null;
    }
  }
}


