// Dependiendo del tamaño de la pantalla mantendrá el SideDrawer visible
import 'package:flutter/material.dart';

import '../../presentation/sidedrawer/pages/sidedrawer_page.dart';
import '../constants.dart';

class ScaffoldManager extends StatelessWidget {
  ScaffoldManager({Key? key, required this.title, required this.child, this.floatingActionButton});

  final PreferredSizeWidget title;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        if(screenWidth >= ScreenSize.maxScreen) {
          return Row(
            children: [
              const SizedBox(
                width: ScreenSize.sizeMenuBox,
                child: SideDrawer(
                  key: ValueKey("sidedrawer"),
                ),
              ),
              Expanded(
                child: Scaffold(
                  appBar: title,
                  body: child,
                  floatingActionButton: floatingActionButton,
                  )
                )
            ],
          );
        } else {
          return Scaffold(
            appBar: title,
            body: child,
            floatingActionButton:floatingActionButton,
            drawer: const SideDrawer(
              key: ValueKey("sidedrawer"),
            ),
          );
        }
      }
}