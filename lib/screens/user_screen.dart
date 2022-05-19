import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

//void main() => runApp(const Permisos());


class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: UserPage(title: appTitle),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({ Key? key, required this.title }) : super(key: key);

  final String title;
  //final String icon = Icons.supervisor_account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            tooltip: 'Perfil',
            onPressed: () {
            },
          )
        ]
      ),
      body: Center(
        child: Column(
          children: [
            TitleSection(title: "Usuarios",subtitle: "Administrador / Usuarios",),
            FilterSection(),
            CardSection(organizacion: "ususario 1",icon: Icons.person,bottonCancel: showCancelUser(context),),
            CardSection(organizacion: "ususario 2",icon: Icons.person,bottonCancel: showCancelUser(context),),
            CardSection(organizacion: "ususario 3",icon: Icons.person,bottonCancel: showCancelUser(context),),
            //Text('Organizaciones!',style: Theme.of(context).textTheme.headline3,),
          ],
        ),
      ),
      /*body: Center(
      child: ListView(
          children: <Widget>[
            Container(
              child: const _LoadingIcon()
            ),
            Container(
              child: ElevatedButton(
                child: const Text('Alerta'),
                  onPressed: () {
                    showAlertDialog(context);
                  }
              ),
            ),
            Container(
              child: ElevatedButton(
                child: const Text('Mensaje'),
                  onPressed: () {
                    showAlertMensaje(context);
                  }
              ),
            ),
            Container(
              child: ElevatedButton(
                child: const Text('Notificador'),
                  onPressed: () {
                    Notificacion();
                  }
              ),
            )
          ]
        )
      ),*/
      
      backgroundColor: Styles.defaultGreengroundColor,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Cuenta'),
            ),
            ListTile(
              title: const Text('Organizaciones'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Organization()));
              },
            ),
            ListTile(
              title: const Text('Usuarios'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => User()));
              },
            ),
            ListTile(
              title: const Text('Permisos'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Permit()));
              },
            ),
          ],
        ),
      ),
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
    onPressed:  () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continuar"),
    onPressed:  () {},
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
      appBar: AppBar(title: Text('Banners'),),
      body: MaterialBanner(
        content: const Text('Error message text'),
        leading: CircleAvatar(child: Icon(Icons.delete)),
        actions: [
          FlatButton(
            child: const Text('ACTION 1'),
            onPressed: () { },
          ),
          FlatButton(
            child: const Text('ACTION 2'),
            onPressed: () { },
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
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle
      ),
    );
  }
}

showCancelUser(BuildContext context) {

  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed:  () {},
  );
  Widget continueButton = TextButton(
    child: Text("Si"),
    onPressed:  () {},
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


