import 'package:flutter/material.dart';

import '../constants.dart';

// Cambia el body dependiendo del tamaño de la pantalla
class BodyFormater extends StatelessWidget {
  BodyFormater({Key? key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        if(screenWidth >= ScreenSize.maxScreen) {
          return SizedBox(
            width: ScreenSize.maxBoxBody,
            child: child,
          );
        } else if(screenWidth < ScreenSize.maxScreen && screenWidth >= ScreenSize.minScreen) {
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