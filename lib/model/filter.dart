import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class FilterSection extends StatelessWidget {
  
  const FilterSection({
    Key? key, 
  }) : super(key: key);

  static final snackBar = SnackBar(
              content: const Text('Se a desactivado la organización'),
              action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
        duration: const Duration(milliseconds: 1000),
      );


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(""),
            )
          ),
          IconButton(
            icon: Icon(Icons.filter_alt), 
            color: Colors.blue,
            onPressed: () {
            },
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            icon: Icon(Icons.filter_list_rounded), 
            color: Colors.blue,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(FilterSection.snackBar);
            },
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}