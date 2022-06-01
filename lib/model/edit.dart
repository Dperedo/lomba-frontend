import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class EditSection extends StatefulWidget {

  EditSection({Key? key}) : super(key: key);

  @override
  _EditSection createState() => _EditSection();
}

class _EditSection extends State<EditSection> {

  bool _visible = false;

  static final snackBar_guardar = SnackBar(
              content: const Text('Se a guardado correctamente'),
              action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
        duration: const Duration(milliseconds: 1000),
      );
  static final snackBar_eliminar = SnackBar(
              content: const Text('Se a eliminado correctamente'),
              action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
        duration: const Duration(milliseconds: 1000),
      );
  String dropdownValue = 'Lomba';
  List<String> dropdownItems = ['One', 'Two', 'Free', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nombre',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
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
                    )
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
                            child: Text('organización 1',
                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (() {
                            }),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: (() {
                              ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar_eliminar);
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
                            child: Text('organización 2',
                            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (() {
                            }),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: (() {
                              ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar_eliminar);
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                _visible = !_visible;
              });
            }, 
            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Agregar organización',
                          style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3),
                          ),
                        ),
          ),
          AnimatedOpacity(
          // Si el Widget debe ser visible, anime a 1.0 (completamente visible). Si
          // el Widget debe estar oculto, anime a 0.0 (invisible).
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
          // El cuadro verde debe ser el hijo de AnimatedOpacity
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
