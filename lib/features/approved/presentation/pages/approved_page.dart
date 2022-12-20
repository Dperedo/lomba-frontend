import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

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
