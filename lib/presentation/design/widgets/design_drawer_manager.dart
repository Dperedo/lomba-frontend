// Dependiendo del tamaño de la pantalla mantendrá el SideDrawer visible
import 'package:flutter/material.dart';

//import '../../presentation/sidedrawer/pages/sidedrawer_page.dart';
import '../design_constants.dart';

class DrawerManager extends StatelessWidget {
  const DrawerManager(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: colorFromFlutter("#DFFFC5"),
    );
  }

  Color colorFromFlutter (String color) {
    return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  }
}