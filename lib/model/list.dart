import 'package:flutter/material.dart';
import 'package:front_lomba/model/models.dart';

//import 'package:front_lomba/model/models.dart';

class ListSection extends StatelessWidget {

  final String user;
  
  ListSection({
    Key? key, 
    required this.user
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
                //child: Text(this.organizacion, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.4),),
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    this.user,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.4),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
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
            //showdDelete(context);
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
                          )),
                    ),
                  ),
                ),
              ).then((value) =>
                  ScaffoldMessenger.of(context).showSnackBar(this._snackBar));
          },  
          child: Icon(Icons.do_not_disturb_on),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(  
          onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    onPressed:  () {},
  );
  Widget continueButton = TextButton(
    child: Text("Si"),
    onPressed:  () {},
  );

  AlertDialog alert = AlertDialog(
    content: Text("¿Seguro deseas desactivar al usuario?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
}


/*class SnackBarsDemo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snackbars'),
        actions: [SnackbarButton()],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'replace with url for snackbars-background.jpg after merge'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SnackbarButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Text label'),
          action: SnackBarAction(
            label: 'Action',
            onPressed: () {},
          ),
        );

        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Text('Show SnackBar'),
    );
  }
}*/
