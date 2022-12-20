import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

class AddContentPage extends StatelessWidget {
  const AddContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar contenido")),
      body: const Center(child: Text("Página para agregar contenido")),
      drawer: const SideDrawer(),
    );
  }
}
