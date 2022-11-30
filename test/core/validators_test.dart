import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/validators.dart';

void main() {
  test('debe retornar campo requerido cuando el email id es vacío', () {
    // Arrange & Act
    var result = Validators.validateEmail('');
    // Assert
    expect(result, "Campo Requerido");
  });

  test('debe pedir un correo válido cuando el correo sea inválido', () {
    // Arrange & Act
    var result = Validators.validateEmail('asjdhkjashd');
    // Assert
    expect(result, "Por favor ingresa un email válido");
  });

  test('debe validar un correo válido o correcto', () {
    // Arrange & Act
    var result = Validators.validateEmail('abc@gmail.com');
    // Assert
    expect(result, null);
  });

  test('debe retornar campo requerido cuando la contraseña sea vacía', () {
    // Arrange & Act
    var result = Validators.validatePassword('');
    // Assert
    expect(result, "Campo Requerido");
  });

  test('debe pedir contraseña válida cuando no cumpla', () {
    // Arrange & Act
    var result = Validators.validatePassword('pas');
    // Assert
    expect(result, "Por favor ingresa una contraseña de al menos 4 caracteres");
  });

  test('debe validar una contraseña correcta según lo requerido', () {
    // Arrange & Act
    var result = Validators.validatePassword('password');
    // Assert
    expect(result, null);
  });
}
