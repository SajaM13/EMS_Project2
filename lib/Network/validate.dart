/*extension extvalidate on String {
  bool get isvalidEmail {
    final emailRegExp = RegExp(r'^[a-zA-z0-9.]+@[a-zA-Z0-9]\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  bool get isvalidname {
    final nameRegExp = RegExp(r'^[a-zA-Z]+$');
    ;
    return nameRegExp.hasMatch(this);
  }

  bool get isvalidpassword {
    final phoneRegExp = RegExp(r'^\+?963[0-9]{10}$');
    return phoneRegExp.hasMatch(this);
  }

  bool get isvalidphone {
    final passRegExp = RegExp(
        r'^(?=.*?[A-z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }
}
*/