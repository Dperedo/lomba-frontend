import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/helpers/route_animation.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: EditProfilePage(title: appTitle),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(UserScreen())),
          ), 
      ),
      body: Center(
        child: Column(
          children: [
            TitleSection(
              title: "Editar usuario",
              subtitle: "Administrador / Todos usuarios / Editar Perfil",
            ),
            EditSection(),
          ],
        ),
      ),
    );
  }
}
