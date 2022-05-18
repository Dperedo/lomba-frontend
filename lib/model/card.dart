import 'package:flutter/material.dart';

//import 'package:front_lomba/model/models.dart';

class CardSection extends StatelessWidget {

  final String organizacion;
  
  const CardSection({
    Key? key, 
    required this.organizacion
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(28.0),
      child: Row(
        children: [
          Icon(Icons.business),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Text(this.organizacion),
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