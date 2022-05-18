import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  
  const FilterSection({
    Key? key, 
  }) : super(key: key);


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
          },  
          child: Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
    );
  }
}