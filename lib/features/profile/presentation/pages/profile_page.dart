import 'package:flutter/material.dart';

import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';

///Página con el perfil del usuario
///
///La página es sólo para usuarios con sesión activa.
///Se deberían indicar aquí datos personales, contraseña, foto y demás
///cosas del usuario.
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: const Center(child: Text("Página de perfil del usuario")),
      drawer: const SideDrawer(),
    );
  }
}
