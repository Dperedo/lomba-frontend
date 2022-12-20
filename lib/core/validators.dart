import 'package:jwt_decode/jwt_decode.dart';

///Clase con validaciones que utiliza el sistema.
class Validators {
  ///Validación de email.
  ///
  ///Debe no ser vacío y cumplir con el patrón de correo electrónico.
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

    return null;
  }

  ///Validación de password
  ///
  ///Debe no ser vacío y cumplir con un largo mínimo.
  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Campo Requerido";
    }

    if (password.length < 4) {
      return "Por favor ingresa una contraseña de al menos 4 caracteres";
    }

    return null;
  }

  ///Validación de token de usuario.
  ///
  ///Debe no ser vacío, estar vigente (no expirado) y contener la clave "userId"
  static bool validateToken(String token) {
    if (token == "") return false;
    if (Jwt.isExpired(token)) return false;

    final payload = Jwt.parseJwt(token);
    if (payload.containsKey("userId")) {
      return true;
    }

    return false;
  }
}
