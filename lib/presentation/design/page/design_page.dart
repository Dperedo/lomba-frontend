import 'package:flutter/material.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diseño"),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: const [Text("Página de diseño")],
        ),
      )),
      drawer: const Drawer(
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
