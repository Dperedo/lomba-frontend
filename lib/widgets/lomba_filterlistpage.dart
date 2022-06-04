import 'package:flutter/material.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class LombaFilterListPage extends StatelessWidget {
  const LombaFilterListPage({
    Key? key,
  }) : super(key: key);

  static final snackBar = SnackBar(
    content: const Text('Se ha desactivado la organización'),
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
          Expanded(
              child: Container(
            child: Text(""),
          )),
          IconButton(
            icon: Icon(Icons.filter_alt),
            color: Provider.of<ThemeProvider>(context).getIndicatorColor(),
            onPressed: () {},
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            icon: Icon(Icons.filter_list_rounded),
            color: Provider.of<ThemeProvider>(context).getIndicatorColor(),
            onPressed: () {
              //ScaffoldMessenger.of(context).showSnackBar(LombaFilterListPage.snackBar);
            },
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
