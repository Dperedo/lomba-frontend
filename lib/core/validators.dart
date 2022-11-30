class Validators {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Campo Requerido";
    }

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      return "Por favor ingresa un email válido";
    }
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Campo Requerido";
    }

    if (password.length < 8) {
      return "Por favor ingresa una contraseña de al menos 4 caracteres";
    }
  }
}
