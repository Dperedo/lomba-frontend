import 'package:flutter/material.dart';
import 'package:front_lomba/model/models.dart';

//import 'package:front_lomba/model/models.dart';

class ListSection extends StatelessWidget {
  final String user;

  ListSection({Key? key, required this.user}) : super(key: key);

  final _snackBarCancel = SnackBar(
    content: const Text('Se a desactivado el usuario'),
    duration: const Duration(milliseconds: 1500),
    /*width: 280.0, // Width of the SnackBar.
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),*/
  );

  final _snackBarDelete = SnackBar(
    content: const Text('Se ha eliminado el usuario'),
    duration: const Duration(milliseconds: 1500),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Center(
            child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    this.user,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.4),
                  ),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (context) => GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Builder(
                            builder: (context) => GestureDetector(
                                onTap: () {
                                  //Navigator.of(context).push(_createAlertRoute());
                                }, 
                                child: UserDetailSection()
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          )),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
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
                            title: 'Desactivar Usuario',
                            dialog: 'Desea desactivar al usuario ' + this.user,
                          )),
                    ),
                  ),
                ),
              ).then((value) => {
                    if (value == 'Sí')
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(this._snackBarCancel)
                      },
                  });
            },
            child: Icon(Icons.do_not_disturb_on),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
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
                            title: 'Eliminar Usuario',
                            dialog: 'Desea eliminar al usuario ' + this.user,
                          )),
                    ),
                  ),
                ),
              ).then((value) => {
                    if (value == 'Sí')
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(this._snackBarDelete)
                      },
                  });
            },
            child: Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}

showdDelete(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Si"),
    onPressed: () {},
  );

  AlertDialog alert = AlertDialog(
    content: Text("¿Seguro deseas desactivar al usuario?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
}
