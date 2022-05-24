import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class CardSection extends StatelessWidget {

  final String organizacion;
  final IconData icon;
  //final Widget bottonCancel;
  
   CardSection({
    Key? key, 
    required this.organizacion,
    required this.icon,
    //required this.bottonCancel,
  }) : super(key: key);

final snackBar = SnackBar(
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
          Icon(this.icon),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Center(
              child: Align(
                //child: Text(this.organizacion, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.4),),
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(this.organizacion, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.4),),
                  onPressed: () {
                  },
                )
              ),
            )
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(  
          onPressed: () {
            //showCancel1(context, this.snackBar);
            //ScaffoldMessenger.of(context).showSnackBar(this.snackBar);
            showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertSection(title: 'Aviso',dialog: 'Desea cambiar',));
            //AlertSection(title: 'Aviso',dialog: 'Desea cambiar',);
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

showCancel1(BuildContext context,SnackBar snack) {

  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed:  () {},
  );
  Widget continueButton = TextButton(
    child: Text("Si"),
    onPressed:  () {
      Navigator.pop(context, 'Si');
      
      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      //ScaffoldMessenger.of(context).showSnackBar(snack);
    }, 
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

