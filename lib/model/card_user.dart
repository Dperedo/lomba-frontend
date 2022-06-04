import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/helpers/route_animation.dart';

class CardUserSection extends StatelessWidget {
  final String username;
  final IconData icon;
  //final Widget bottonCancel;

  CardUserSection({
    Key? key,
    required this.username,
    required this.icon,
    //required this.bottonCancel,
  }) : super(key: key);

  final _snackBar = SnackBar(
    content: Text('Se a desactivado el usuario'),
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
                    this.username,
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
                                child: UserDetailDialog()),
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
            heroTag: null,
            onPressed: () {},
            child: Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
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
                            title: 'Desactivar usuario',
                            dialog:
                                'Desea desactivar el usuario ' + this.username,
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
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(UserEdit()));
            },
          ),
        ],
      ),
    );
  }
}
