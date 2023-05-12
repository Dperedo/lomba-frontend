// Dependiendo del tamaño de la pantalla mantendrá el SideDrawer visible
import 'package:flutter/material.dart';

//import '../../presentation/sidedrawer/pages/sidedrawer_page.dart';
import '../design_constants.dart';

class DesignScaffoldManager extends StatelessWidget {
  const DesignScaffoldManager(
      {super.key,
      required this.title,
      required this.child,
      this.floatingActionButton});

  final PreferredSizeWidget? title;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= ScreenSize.maxScreen) {
      return Row(
        children: [
          SizedBox(
            width: ScreenSize.sizeMenuBox,
            child: Drawer(
              backgroundColor: colorFromFlutter("#DFFFC5"),
            ),
            /*SideDrawer(
              key: ValueKey("sidedrawer"),
            ),*/
          ),
          Expanded(
              child: Scaffold(
            appBar: title,
            body: Container(
              color: colorFromFlutter("#DFFFC5"),
              child: child
              ),
            floatingActionButton: floatingActionButton,
          ))
        ],
      );
    } else {
      return Scaffold(
        appBar: title,
        body: Container(
          color: colorFromFlutter("#DFFFC5"),
          child: child
          ),
        floatingActionButton: floatingActionButton,
        drawer: const Drawer(
          backgroundColor: Colors.lightGreen,
        ),
        /*const SideDrawer(
          key: ValueKey("sidedrawer"),
        ),*/
      );
    }
  }

  Color colorFromFlutter (String color) {
    return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
