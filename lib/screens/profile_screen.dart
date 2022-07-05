import 'package:flutter/material.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/helpers/preferences.dart';
import 'package:front_lomba/screens/administration/user_edit_screen.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_sized_screen.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: const UserProfilePage(title: appTitle),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int breakpoint = Preferences.maxScreen;
    if (screenWidth <= breakpoint) {
      return SmallScreen(title: title, principal: const ProfileBody());
    } else {
      return BigScreen(title: title, principal: const ProfileBody());
    }
    /*return Scaffold(
      appBar: LombaAppBar(title: title),
      body: ProfileBody(),
      drawer: const LombaSideMenu(),
    );*/
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            UserProfileContent(),
          ],
        ),
      ),
    );
  }
}

class UserProfileContent extends StatelessWidget {
  const UserProfileContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Column(children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("add you image URL here "),
                      fit: BoxFit.cover)),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: const Alignment(0.0, 2.5),
                  child: const CircleAvatar(
                    /*backgroundImage: NetworkImage(
                      "Add you UserProfile DP image URL here "
                  ),*/
                    backgroundColor: Colors.blue,
                    radius: 60.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Diego Peredo",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Email: dperedo@gmail.com",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Lomba",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
          ]),
        ));
  }
}
