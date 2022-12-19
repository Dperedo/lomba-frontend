import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

class ToBeApprovedPage extends StatelessWidget {
  const ToBeApprovedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Por aprobar")),
      body: const Center(child: Text("Página para aprobar")),
      drawer: const SideDrawer(),
    );
  }
}
