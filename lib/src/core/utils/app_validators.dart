import '../constants/constants.dart';
import 'app_helpers.dart';

class AppValidators {
  static bool isValidEmail(String email) => RegExp(
        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$",
      ).hasMatch(email);

  static bool isValidPhone(String? phone) => RegExp(
        r"^\+\d{1,3}\d{9}$",
      ).hasMatch(phone ?? '');

  static bool isValidPassword(String password) => password.length > 7;

  static bool arePasswordsTheSame(String password, String confirmPassword) =>
      password == confirmPassword;

  static String? emptyCheck(String? text) {
    if (text == null || text.trim().isEmpty) {
      return AppHelpers.getTranslation(TrKeys.cannotBeEmpty);
    }
    return null;
  }

  static String? isNumberValidator(String? title) {
    if (title?.isEmpty ?? true) {
      return AppHelpers.getTranslation(TrKeys.thisFieldIsRequired);
    }
    if ((num.tryParse(title ?? "") ?? 0.0).isNegative) {
      return AppHelpers.getTranslation(TrKeys.thisFieldIsNotMinusOrZero);
    }
    return null;
  }

  static String? emailCheck(String? text) {
    if (text == null || text.trim().isEmpty) {
      return AppHelpers.getTranslation(TrKeys.cannotBeEmpty);
    }
    if (!isValidEmail(text)) {
      return AppHelpers.getTranslation(TrKeys.emailIsNotValid);
    }
    return null;
  }
}
