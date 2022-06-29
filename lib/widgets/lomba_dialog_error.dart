import 'package:flutter/material.dart';

class LombaDialogErrorDisconnect extends StatelessWidget {
  const LombaDialogErrorDisconnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Not Connection'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Conexión con el servidor no establecido'),
            SizedBox(
            width: 20,
            ),
            Icon(Icons.wifi_off),
          ],
        ),
      )
    );
  }
}

class LombaDialogError400 extends StatelessWidget {
  const LombaDialogError400({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error 400'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Ocurrió una solicitud Incorrecta'),
          ],
        ),
      ));
  }
}

class LombaDialogError401 extends StatelessWidget {
  const LombaDialogError401({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error authenticator'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Ocurrió un problema con la autentificación'),
          ],
        ),
      ));
  }
}

class LombaDialogError403 extends StatelessWidget {
  const LombaDialogError403({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Solicitud denegada'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Ocurrió un problema con la Solicitud'),
          ],
        ),
      ));
  }
}

class LombaDialogError extends StatelessWidget {
  const LombaDialogError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Would you like to approve of this message?'),
          ],
        ),
      ));
  }
}