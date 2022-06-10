import 'package:flutter/material.dart';

class LombaSnackBar extends StatefulWidget implements SnackBar {
  LombaSnackBar({Key? key, required this.message}) : super(key: key);

  final String message;

  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 2500),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
