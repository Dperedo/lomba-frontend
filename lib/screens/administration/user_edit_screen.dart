import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/snackbars.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/helpers/route_animation.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';

class UserEdit extends StatelessWidget {
  const UserEdit({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';
  static const pageTitle = 'Editar usuario';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle + ' - ' + pageTitle,
      home: UserEditPage(title: appTitle + ' - ' + pageTitle),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class UserEditPage extends StatelessWidget {
  const UserEditPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarToBack(context),
      body: Center(
        child: Column(
          children: [
            TitleSection(
              title: "Editar usuario",
              subtitle: "Administrador / Todos usuarios / Editar Perfil",
            ),
            UserEditForm(),
          ],
        ),
      ),
    );
  }

  AppBar appBarToBack(BuildContext context) {
    return AppBar(
        title: Text(title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  RouteAnimation.animatedTransition(AllUsers()));
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
                  .push(RouteAnimation.animatedTransition(AllUsers()))
                  .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBarGenerator.getNotificationMessage(
                          'Cambios guardados')));
            },
          )
        ]);
  }
}

class UserEditForm extends StatefulWidget {
  UserEditForm({Key? key}) : super(key: key);

  @override
  _UserEditForm createState() => _UserEditForm();
}

class _UserEditForm extends State<UserEditForm> {
  bool _visible = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  String dropdownValue = 'lomba';
  List<String> dropdownItems = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(10.0),
      child: Column(
        children: [
          LombaTextFieldForm(
            labelText: 'Nombre',
          ),
          LombaTextFieldForm(
            labelText: 'Username',
          ),
          LombaTextFieldForm(
            labelText: 'Correo electrónico',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Container(
              child: Wrap(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        'Organizaciones:',
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 1.2),
                      )),
                  Divider(),
                  Container(
                    width: 225,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'organización 1',
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .apply(fontSizeFactor: 1.2),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (() {
                              setState(() {
                                _visible = !_visible;
                              });
                            }),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: (() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBarGenerator.getNotificationMessage(
                                      'Se ha quitado organización del usuario'));
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 225,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'organización 2',
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .apply(fontSizeFactor: 1.2),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (() {
                              setState(() {
                                _visible = !_visible;
                              });
                            }),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: (() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBarGenerator.getNotificationMessage(
                                      'Se ha quitado organización del usuario'));
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 225,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'organización 3',
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .apply(fontSizeFactor: 1.2),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (() {
                              setState(() {
                                _visible = !_visible;
                              });
                            }),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: (() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBarGenerator.getNotificationMessage(
                                      'Se ha quitado organización del usuario'));
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                setState(() {
                  _visible = !_visible;
                });
              },
              label: const Text('Agregar Organización')),
          SizedBox(
            width: 20,
          ),
          AnimatedOpacity(
            // Si el Widget debe ser visible, anime a 1.0 (completamente visible). Si
            // el Widget debe estar oculto, anime a 0.0 (invisible).
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            // El cuadro verde debe ser el hijo de AnimatedOpacity
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 200.0,
                //height: 200.0,
                //color: Colors.green,
                child: Column(
                  children: [
                    const Divider(),
                    DropdownButton(
                      value: dropdownValue,
                      items: [
                        DropdownMenuItem(
                          child: Text('santander'),
                          value: 'santander',
                        ),
                        DropdownMenuItem(
                          child: Text('pawafa'),
                          value: 'pawafa',
                        ),
                        DropdownMenuItem(
                          child: Text('lomba'),
                          value: 'lomba',
                        ),
                      ],
                      onChanged: (String? valor) {
                        setState(() {
                          //texto = valor;
                          dropdownValue = valor!;
                        });
                      },
                    ),
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
                        Text('Super Admin'),
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
                        Text('Admin'),
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
                        Text('Sistema'),
                      ],
                    ),
                    FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          setState(() {
                            _visible = !_visible;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBarGenerator.getNotificationMessage(
                                  'Se ha guardado correctamente'));
                        },
                        label: const Text('Asociar con usuario')),
                  ],
                ),
              ),
            ),
          ),
        ],
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
          border: UnderlineInputBorder(),
          labelText: this.labelText,
        ),
      ),
    );
  }
}
