import 'package:flutter/material.dart';

import '../../../sidedrawer/pages/sidedrawer_page.dart';

class UploadedPage extends StatelessWidget {
  const UploadedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Subidos")),
      body: const Center(child: Text("Página de subidos")),
      drawer: const SideDrawer(),
    );
  }
}
