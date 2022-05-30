//import 'dart:io';
import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: EditProfilePage(title: appTitle),
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
      ),
      body: Center(
        child: Column(
          children: [
            TitleSection(
              title: "Editar usuario",
              subtitle: "Perfil / Editar Perfil",
            ),
            EditSection(),
          ],
        ),
      ),
    );
  }
}

/*
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user1 = UserPreferences.myUser;

  @override
  //Widget build(BuildContext context) => ThemeSwitchingArea(
  Widget build(BuildContext context) => Scaffold(
            appBar: AppBar(
        title: Text('Lomba'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
            },
          )
        ]
      ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user1.imagePath,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user1.name,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user1.email,
                  onChanged: (email) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'About',
                  text: user1.about,
                  maxLines: 5,
                  onChanged: (about) {},
                ),
              ],
            ),
          )
        ;
}

class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
  });
}

//-----------------------------------------------------------

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: widget.maxLines,
          ),
        ],
      );
}

//-----------------------------------------------------------

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

//-----------------------------------------------------------

class UserPreferences {
  static const myUser = User(
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
    about:
        'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );
}

*/