import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class CardSection extends StatelessWidget {
  final String organizacion;
  final IconData icon;
  AlertSection? _alertSection;
  //final Widget bottonCancel;

  CardSection({
    Key? key,
    required this.organizacion,
    required this.icon,
    //required this.bottonCancel,
  }) : super(key: key);

  final _snackBar = SnackBar(
    action: SnackBarAction(
      label: 'Action',
      onPressed: () {
        // Code to execute.
      },
    ),
    content: const Text('Awesome SnackBar!'),
    duration: const Duration(milliseconds: 1500),
    width: 280.0, // Width of the SnackBar.
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    this._alertSection = AlertSection(
      title: 'Aviso',
      dialog: 'Desea cambiar',
      snackBar: _snackBar,
    );

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
                  child: Text(
                    this.organizacion,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.4),
                  ),
                  onPressed: () {},
                )),
          )),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              //showCancel1(context, this.snackBar);

              showDialog<String>(
                context: context,
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Builder(
                      builder: (context) => GestureDetector(
                          onTap: () {},
                          child: AlertSection(
                            title: 'Aviso',
                            dialog: 'Desea cambiar',
                            snackBar: _snackBar,
                          )),
                    ),
                  ),
                ),
              ).then((value) =>
                  ScaffoldMessenger.of(context).showSnackBar(this._snackBar));

/*
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertSection(
                        title: 'Aviso',
                        dialog: 'Desea cambiar',
                        snackBar: _snackBar,
                      ));
*/
              //ScaffoldMessenger.of(context).showSnackBar(this._snackBar);

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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserList()));
            },
          ),
        ],
      ),
    );
  }
}

showCancel1(BuildContext context, SnackBar snack) {
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Si"),
    onPressed: () {
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
