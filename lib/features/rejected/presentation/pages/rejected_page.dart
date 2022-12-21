import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

///Página con los contenidos rechazados por el usuario revisor
///
///La página muestra sólo el contenido rechazado por el usuario conectado
///revisor.
class RejectedPage extends StatelessWidget {
  const RejectedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rechazados")),
      body: const Center(child: Text("Página de rechazados")),
      drawer: const SideDrawer(),
    );
  }
}
