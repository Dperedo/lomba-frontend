import 'package:flutter/material.dart';
import 'package:front_lomba/model/models.dart';

class LombaAppBar extends StatelessWidget implements PreferredSizeWidget {
  LombaAppBar({
    Key? key,
    required this.title,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Lomba'), actions: [
      IconButton(
        icon: const Icon(Icons.account_circle_rounded),
        tooltip: 'Perfil',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        },
      )
    ]);
  }
}
