import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

class ViewedPage extends StatelessWidget {
  const ViewedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vistos")),
      body: const Center(child: Text("Página de ya vistos")),
      drawer: const SideDrawer(),
    );
  }
}
