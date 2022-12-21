import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

///Página con el contenido popular.
///
///Esta página será accedida por los usuarios estén o no con sesión dentro,
///es decir, se mostrará a todos los usuarios no administradores.
class PopularPage extends StatelessWidget {
  const PopularPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Populares")),
      body: const Center(child: Text("Página de populares")),
      drawer: const SideDrawer(),
    );
  }
}
