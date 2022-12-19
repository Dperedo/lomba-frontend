import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

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
