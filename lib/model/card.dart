import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class CardSection extends StatelessWidget {

  final String organizacion;
  final IconData icon;
  final Widget bottonCancel;
  
  const CardSection({
    Key? key, 
    required this.organizacion,
    required this.icon,
    required this.bottonCancel,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(this.icon),
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
            showCancel1(context);
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

showCancel1(BuildContext context) {

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