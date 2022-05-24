import 'package:flutter/material.dart';

class AlertSection extends StatelessWidget {
  final String title;
  final String dialog;
  final SnackBar snackBar;

  const AlertSection(
      {Key? key,
      required this.title,
      required this.dialog,
      required this.snackBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.dialog),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'No'),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(this.snackBar);

            Navigator.pop(context, 'Si');
          },
          child: const Text('Sí'),
        ),
      ],
    );
  }
}
