import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class AlertSection extends StatelessWidget {

  final String title;
  final String dialog;

  const AlertSection({
    Key? key, 
    required this.title,
    required this.dialog,
  }) : super(key: key);


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
                onPressed: () => Navigator.pop(context, 'Si'),
                child: const Text('Si'),
              ),
            ],
          );
  }
}