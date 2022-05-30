import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';

//void main() => runApp(const Permisos());

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: UserPage(title: appTitle),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.title}) : super(key: key);

  final String title;
  //final String icon = Icons.supervisor_account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          tooltip: 'Perfil',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleSection(
              title: "Todos los usuarios",
              subtitle: "Administrador / Todos usuarios",
            ),
            FilterSection(),
            Divider(),
            CardUserSection(
              organizacion: "username 1",
              icon: Icons.person,
            ),
            Divider(),
            CardUserSection(
              organizacion: "username 2",
              icon: Icons.person,
            ),
            Divider(),
            CardUserSection(
              organizacion: "username 3",
              icon: Icons.person,
            ),
            Divider(),
          ],
        ),
      ),
      drawer: LombaSideMenu(),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Alerta"),
    content: Text("Esto es una alerta."),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertMensaje(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continuar"),
    onPressed: () {},
  );

  AlertDialog alert = AlertDialog(
    title: Text("Mensaje"),
    content: Text("Este en un mensaje"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Notificacion extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banners'),
      ),
      body: MaterialBanner(
        content: const Text('Error message text'),
        leading: CircleAvatar(child: Icon(Icons.delete)),
        actions: [
          FlatButton(
            child: const Text('ACTION 1'),
            onPressed: () {},
          ),
          FlatButton(
            child: const Text('ACTION 2'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
    );
  }
}

showCancelUser(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Si"),
    onPressed: () {},
  );

  AlertDialog alert = AlertDialog(
    content: Text("¿Seguro deseas desactivar la organización Lomba?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
