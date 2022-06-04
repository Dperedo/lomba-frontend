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

  final _snackBar = SnackBar(
    content: Text('Se a desactivado la organización'),
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
            heroTag: null,
            onPressed: () {
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
                            title: 'Desactivar organización',
                            dialog: 'Desea desactivar la organización ' +
                                this.organizacion,
                          )),
                    ),
                  ),
                ),
              ).then((value) => {
                    if (value == 'Sí')
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(this._snackBar)
                      },
                  });
            },
            child: Icon(Icons.do_not_disturb_on),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.supervised_user_circle),
            onPressed: () {
              //    Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => UserList()));
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
      Navigator.pop(context, 'Sí');
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
