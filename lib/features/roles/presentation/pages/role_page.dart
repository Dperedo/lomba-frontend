import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

class RolesPage extends StatelessWidget {
  const RolesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Roles")),
      body: const Center(child: Text("Página de roles")),
      drawer: const SideDrawer(),
    );
  }
}
