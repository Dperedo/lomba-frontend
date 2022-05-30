import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class EditSection extends StatelessWidget {
  
  EditSection({
    Key? key, 
  }) : super(key: key);

  static final snackBar = SnackBar(
              content: const Text('Se a guardado correctamente'),
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
        ],
      ),
    );
  }
}
