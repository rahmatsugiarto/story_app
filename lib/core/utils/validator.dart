class Validator {
  static String? validateEmailForm(
    String? value, {
    required String emptyMsg,
    required String notValidEmailMsg,
  }) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return emptyMsg;
    }

    if (!regex.hasMatch(value)) {
      return notValidEmailMsg;
    }
    return null;
  }

  static String? validateEmptyForm(
    String? value, {
    required String emptyMsg,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMsg;
    }
    return null;
  }

  static String? validatePassForm(
    String? value, {
    required String emptyMsg,
    required String shortMsg,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMsg;
    } else if (value.length < 8) {
      return shortMsg;
    }
    return null;
  }
}
