import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/snackbars.dart';

import 'package:front_lomba/helpers/route_animation.dart';
import 'package:front_lomba/screens/administration/allusers_screen.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/services/organization_service.dart';
import 'package:front_lomba/services/alluser_service.dart';
import 'package:front_lomba/services/organization_userslist_services.dart';

class UserEdit extends StatelessWidget {
  const UserEdit({Key? key, required this.user}) : super(key: key);

  final String user;
  static const appTitle = 'Lomba';
  static const pageTitle = 'Editar usuario';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$appTitle - $pageTitle',
      home: UserEditPage(title: '$appTitle - $pageTitle', iduser: user),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class UserEditPage extends StatelessWidget {
  const UserEditPage({Key? key, 
  required this.title, 
  required this.iduser}) 
  : super(key: key);

  final String title;
  final String iduser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarToBack(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LombaTitlePage(
              title: "Editar usuario",
              subtitle: "Administrador / Todos usuarios / Editar Perfil",
            ),
            UserEditForm(user: iduser),
          ],
        ),
      ),
    );
  }

  AppBar appBarToBack(BuildContext context) {
    return AppBar(
        title: Text(title),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  RouteAnimation.animatedTransition(const AllUsers()));
            }),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Guardar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBarGenerator.getNotificationMessage(
                      'Cambios guardados'));

              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(const AllUsers()))
                  .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBarGenerator.getNotificationMessage(
                          'Cambios guardados')));
            },
          )
        ]);
  }
}

class UserEditForm extends StatefulWidget {
  const UserEditForm({Key? key, required this.user}) : super(key: key);

  final String user;

  @override
  UserEditFormState createState() => UserEditFormState(iduser: user);
}

class UserEditFormState extends State<UserEditForm> {
  UserEditFormState({ required this.iduser});
  String iduser;
  bool _visible = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  List<dynamic> listaRoles = ['superadmin','admin','basic'];

  String dropdownValue = 'Lomba';
  List<String> dropdownItems = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'];

  String orgaid = '';
  List<dynamic> roles = [];

  @override
  Widget build(BuildContext context) {
    
    final organizationService = Provider.of<OrganizationService>(context, listen: false);
    final userService = Provider.of<UserService>(context, listen: false);
    final userEditService = Provider.of<OrganizationUserslistService>(context, listen: false);

    //FutureList<Map<String, dynamic>?>? Buscar (String )

    /*List<Map<String, dynamic>?>? usuario = await userService.SearchUser(iduser);
    if (usuario[0]["roles"]["name"]== 'superadmin'){
      isChecked1 = true;
    }*/

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            /*const LombaTextFieldForm(
              labelText: 'Nombre',
            ),
            const LombaTextFieldForm(
              labelText: 'Username',
            ),
            const LombaTextFieldForm(
              labelText: 'Correo electrónico',
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: Wrap(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Organizaciones:',
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 1.2),
                          ),
                        )),
                    const Divider(),
                    SizedBox(
                      width: 225,
                      child: Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.zero,
                            child: FutureBuilder(future: userService.SearchUser(iduser),
                              builder: (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
                              if (snapshot.data == null) {
                                return Text('nada');
                              }
                              final us = snapshot.data;
                              //print(us);
                              print(us?.length);
                              print('eso fue la lista de usuarios');
                              return Column(
                                children: [
                                  //Text('data1'),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: us?.length,
                                    itemBuilder: (context, index){
                                      //final object =us?[index]["orga"]["name"];
                                      
                                      return //Text('data2');
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Text(
                                              us?[index]["orga"]["name"],
                                              //'superuser',
                                              style: DefaultTextStyle.of(context)
                                                  .style
                                                  .apply(fontSizeFactor: 1.2),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: (() {
                                              setState(() {
                                                print('antes del for');
                                                for(var i=0; i<us?[index]["roles"].length;i++){
                                                  print('hola');
                                                  if (us?[index]["roles"][i]["name"] == 'superadmin') {// us?[index]!["roles"]["name"]
                                                    isChecked1 = true;
                                                  }
                                                  if (us?[index]["roles"][i]["name"] == 'admin') {
                                                    isChecked2 = true;
                                                  }
                                                  if (us?[index]["roles"][i]["name"] == 'basic') {
                                                    isChecked3 = true;
                                                  }
                                                }
                                                orgaid = us?[index]["orga"]["id"];
                                                print(us?[index]["orga"]["name"]);
                                                dropdownValue = us?[index]["orga"]["name"];
                                                _visible = !_visible;
                                                print('despues del for');
                                              });
                                            }),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.cancel),
                                            onPressed: (() async {
                                              print('Antes de agregar la orga');
                                              final bool message = await userEditService.DeleteUsers(us?[index]["orga"]["id"],iduser);
                                              if(message == true) {
                                                print('OK');
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBarGenerator.getNotificationMessage(
                                                      'Se ha quitado organización del usuario'));
                                              }else{
                                                print('error');
                                              }
                                            }),
                                          ),
                                        ],
                                      );
                                    }
                                  )
                                ],
                              );}
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      setState(() {
                        isChecked1 = false;
                        isChecked2 = false;
                        isChecked3 = false;
                        _visible = !_visible;
                      });
                    },
                    label: const Text('+ Agregar Organización')
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            AnimatedOpacity(
              // Si el Widget debe ser visible, anime a 1.0 (completamente visible). Si
              // el Widget debe estar oculto, anime a 0.0 (invisible).
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              // El cuadro verde debe ser el hijo de AnimatedOpacity
              child: Align(
                alignment: Alignment.centerLeft,
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 300.0,
                  //height: 200.0,
                  //color: Colors.green,
                  child: Column(
                    children: [
                      //const Divider(),
                      FutureBuilder(
                        future: organizationService.OrganizationList(),
                        builder: (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
                          final orga = snapshot.data;
                          final numOrgas = orga?.length;
                          //print('resultado de orga');
                          //print(orga?[0]["name"]);
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 55),
                              child: DropdownButton(
                                hint: Text('Seleccionar'),
                                value: dropdownValue,
                                items: snapshot.data?.map((fc) =>
                                  DropdownMenuItem<String>(
                                    value: fc?["name"],
                                    child: Text(fc?["name"]),
                                    )
                                ).toList(), 
                                onChanged: (newValue) {
                                  setState(() {
                                    for(var i=0; i<numOrgas!;i++){
                                      if (orga?[i]["name"]==newValue.toString()){
                                        orgaid = orga?[i]["id"];
                                      }
                                    }
                                    dropdownValue = newValue.toString();
                                  });
                                },
                              ),
                            ),
                          );
                        }
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: isChecked1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked1 = value!;
                                    });
                                  },
                                ),
                                const Text('Super Admin'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: isChecked2,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked2 = value!;
                                    });
                                  },
                                ),
                                const Text('Admin'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  //fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: isChecked3,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked3 = value!;
                                    });
                                  },
                                ),
                                const Text('Basic'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () async {
                              setState(() {
                                if(isChecked1 == true) {
                                  roles.add('superadmin');
                                }
                                if(isChecked2 == true) {
                                  roles.add('admin');
                                }
                                if(isChecked3 == true) {
                                  roles.add('basic');
                                }
                                _visible = !_visible;
                              });
                              final String? errorMessage = await organizationService.OrganizationAdd(orgaid,iduser,roles);
                              if (errorMessage == null ){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBarGenerator.getNotificationMessage(
                                      'Se ha guardado correctamente'));
                                      } else {print('no guardo');}
                            },
                            label: const Text('Asociar con usuario')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Set<MaterialState> _interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  Color getBackgroundColor(Set<MaterialState> states) {
    if (states.any(_interactiveStates.contains)) {
      return Provider.of<ThemeProvider>(context).currentTheme.indicatorColor;
    }
    return Provider.of<ThemeProvider>(context).currentTheme.primaryColor;
  }

  Color getTextColor(Set<MaterialState> states) {
    if (states.any(_interactiveStates.contains)) {
      return Provider.of<ThemeProvider>(context)
          .currentTheme
          .secondaryHeaderColor;
    }
    return Provider.of<ThemeProvider>(context).currentTheme.backgroundColor;
  }
}

class LombaTextFieldForm extends StatelessWidget {
  final String labelText;

  const LombaTextFieldForm({Key? key, required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
/*class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);
    String dropdownValue = 'Lomba';
    return Center(
      child: FutureBuilder(
                        future: userService.UserList(),
                        builder: (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
                          //final lista = snapshot.data;
                          //return 
                        }
                      ),
    );
  }
}*/
