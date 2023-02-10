import 'package:flutter/material.dart';

import '../presentation/sidedrawer/pages/sidedrawer_page.dart';
import 'constants.dart';

// Cambia el body dependiendo del tamaño de la pantalla
class ScreenBody extends StatelessWidget {
  ScreenBody({Key? key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        if(screenWidth >= ScreenSize.maxScreen) {
          return SizedBox(
            width: 650,
            child: child,
          );
        } else if(screenWidth < ScreenSize.maxScreen && screenWidth >= ScreenSize.minScreen) {
          return SizedBox(
            width: 550,
            child: child,
          );
        } else {
          return SizedBox(
            child: child,
          );
        }
      }
}

// Dependiendo del tamaño de la pantalla mantendrá el SideDrawer visible
class ShowMenu extends StatelessWidget {
  ShowMenu({Key? key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        if(screenWidth >= ScreenSize.maxScreen) {
          return Row(
            children: [
              const SizedBox(
                width: 300,
                child: SideDrawer(),
              ),
              Expanded(
                child: Scaffold(
                  appBar: AppBar(title: Text(title),),
                  body: child,
                  )
                )
            ],
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: Text(title),),
            body: child,
            drawer: const SideDrawer(),
          );
        }
      }
}