import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class CardSection extends StatelessWidget {

  final String organizacion;
  
  const CardSection({
    Key? key, 
    required this.organizacion
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
              child: Text(this.organizacion, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.4),),
            )
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(  
          onPressed: () {
            showCancel(context);
          },  
          child: Icon(Icons.do_not_disturb_on),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(    
          child: Icon(Icons.supervised_user_circle),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserList()));
          },
          ),
        ],
      ),
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