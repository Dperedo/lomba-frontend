import 'package:flutter/material.dart';
import 'package:front_lomba/model/models.dart';

//import 'package:front_lomba/model/models.dart';

class ListPermissionSection extends StatelessWidget {
  final String permission;

  ListPermissionSection({Key? key, required this.permission}) : super(key: key);

  final _snackBarCancel = SnackBar(
    content: const Text('Se ha desactivado el permiso'),
    duration: const Duration(milliseconds: 2000),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(Icons.key),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Center(
            child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    this.permission,
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
                            title: 'Desactivar Permiso',
                            dialog: '¿Desea desactivar el permiso ' +
                                this.permission +
                                '?',
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
        ],
      ),
    );
  }
}
