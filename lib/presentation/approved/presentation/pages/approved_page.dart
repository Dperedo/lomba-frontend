import 'package:flutter/material.dart';

import '../../../sidedrawer/pages/sidedrawer_page.dart';

///Página con el contenido que el usuario revisor ha aprobado anteriormente.
///
///Se mostrará un listado con todo aquel contenido que el usuario haya
///aprobado anteriormente desde la página de "Por Aprobar"
class ApprovedPage extends StatelessWidget {
  const ApprovedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aprobados")),
      body: const Center(child: Text("Página de aprobados")),
      drawer: const SideDrawer(),
    );
  }
}
