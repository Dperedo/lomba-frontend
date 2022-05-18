import 'package:flutter/material.dart';

//import 'package:front_lomba/model/models.dart';

class ListSection extends StatelessWidget {

  final String user;
  
  const ListSection({
    Key? key, 
    required this.user
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(Icons.business),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Text(this.user),
            )
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(  
          onPressed: () {},  
          child: Icon(Icons.do_not_disturb_on),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(  
          onPressed: () {},  
          child: Icon(Icons.supervised_user_circle),
          ),
        ],
      ),
    );
  }
}