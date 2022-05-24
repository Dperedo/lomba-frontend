import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/router/app_routes.dart';

//void main() => runApp(const Permisos());

class Organization extends StatelessWidget {
  const Organization({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: OrganizationPage(title: appTitle),
    );
  }
}

class OrganizationPage extends StatelessWidget {
  const OrganizationPage({ Key? key, required this.title }) : super(key: key);

  final String title;

  //Array organizacion = ['organizacion 1','organizacion 2','organizacion 3'] as Array<NativeType>, 

  @override
  Widget build(BuildContext context) {
    final menuOptions = AppRoutes.menuOptions;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
            },
          )
        ]
      ),
      body: Center(
        child: Column(
          children: [
            TitleSection(title: "Organizaciones",subtitle: "Administrador / Organizaciones",),
            FilterSection(),
            Divider(),
            CardSection(organizacion: "Organizacion 1",icon: Icons.business,),
            Divider(),
            CardSection(organizacion: "Organizacion 2",icon: Icons.business,),
            Divider(),
            CardSection(organizacion: "Organizacion 3",icon: Icons.business,),
            Divider(),
            //Text('Organizaciones!',style: Theme.of(context).textTheme.headline3,),
          ],
        ),
      ),
      
      
      backgroundColor: Styles.defaultGreengroundColor,
      drawer: DrawerSection(),
    );
  }
}

showCancel(BuildContext context) {

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