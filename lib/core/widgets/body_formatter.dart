import 'package:flutter/material.dart';

import '../constants.dart';

// Cambia el body dependiendo del tamaño de la pantalla
class BodyFormatter extends StatelessWidget {
  const BodyFormatter(
      {super.key, required this.child, required this.screenWidth});
  final double screenWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (screenWidth >= ScreenSize.maxScreen) {
      return SizedBox(
        width: ScreenSize.maxBoxBody,
        child: child,
      );
    } else if (screenWidth < ScreenSize.maxScreen &&
        screenWidth >= ScreenSize.minScreen) {
      return SizedBox(
        width: ScreenSize.minBoxBody,
        child: child,
      );
    } else {
      return SizedBox(
        child: child,
      );
    }
  }
}
