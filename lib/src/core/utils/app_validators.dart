class AppValidators {
  // static bool isValidEmail(String email) => RegExp(
  //       "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$",
  //     ).hasMatch(email);

  static bool isValidPassword(String password) => password.length > 7;

  static bool arePasswordsTheSame(String password, String confirmPassword) =>
      password == confirmPassword;

  static String? emptyCheck(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'No puede estar vacio';
    }
    return null;
  }

  static String? isNumberValidator(String? title) {
    if (title?.isEmpty ?? true) {
      return 'Este campo es requerido';
    }
    if ((num.tryParse(title ?? "") ?? 0.0).isNegative) {
      return 'Este campo debe ser un número positivo';
    }
    return null;
  }

  // static String? emailCheck(String? text) {
  //   if (text == null || text.trim().isEmpty) {
  //     return AppHelpers.getTranslation(TrKeys.cannotBeEmpty);
  //   }
  //   if (!isValidEmail(text)) {
  //     return AppHelpers.getTranslation(TrKeys.emailIsNotValid);
  //   }
  //   return null;
  // }
}
