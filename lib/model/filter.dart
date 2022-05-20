import 'package:flutter/material.dart';

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
          FloatingActionButton(  
          onPressed: () {
          },  
          child: Icon(Icons.filter_alt),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(  
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(FilterSection.snackBar);
          },  
          child: Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
    );
  }
}