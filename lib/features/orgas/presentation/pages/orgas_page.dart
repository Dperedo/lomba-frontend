import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/widgets/sidedrawer.dart';

class OrgasPage extends StatelessWidget {
  const OrgasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("Organizaciones")),
      drawer: const SideDrawer(),
    );
  }
}
