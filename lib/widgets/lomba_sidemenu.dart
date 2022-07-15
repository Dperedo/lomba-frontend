import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/route_animation.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/screens/administration/allusers_screen.dart';
import 'package:front_lomba/screens/administration/organization_screen.dart';
import 'package:front_lomba/screens/administration/permissions_screen.dart';
import 'package:front_lomba/screens/administration/settings_screen.dart';
import 'package:front_lomba/screens/democolors_screen.dart';
import 'package:front_lomba/screens/home_screen.dart';
import 'package:front_lomba/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/services/auth_service.dart';
import 'package:get/get.dart';

class LombaSideMenu extends StatefulWidget {
  const LombaSideMenu({Key? key}) : super(key: key);
  static const appTitle = 'Lomba';
  @override
  State<LombaSideMenu> createState() => _LombaSideMenuState();
}

class _LombaSideMenuState extends State<LombaSideMenu> {
  @override
  build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: FutureBuilder(
          future: authService.readPermiso(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            List<Widget> menu = [];

            final String? permiso = snapshot.data;

            menu.add(
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).getPrimaryColor(),
                ),
                child: Text('Menú principal',
                    style: TextStyle(
                        color: Provider.of<ThemeProvider>(context)
                            .getTextColor())),
              ),
            );

            print(permiso);

            if (permiso == 'superadmin') {
              menu.add(
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context).push(RouteAnimation.animatedTransition(const Home()));
                  },
                ),
              );
              menu.add(
                ListTile(
                  leading: const Icon(Icons.business_center),
                  title: const Text('Organizaciones'),
                  onTap: () {
                    Navigator.of(context).push(
                        RouteAnimation.animatedTransition(Organizations()));
                  },
                ),
              );
              menu.add(
                ListTile(
                  leading: const Icon(Icons.people_outline),
                  title: const Text('Todos los usuarios'),
                  onTap: () {
                    Navigator.of(context)
                        .push(RouteAnimation.animatedTransition(AllUsers()));
                  },
                ),
              );
              menu.add(
                ListTile(
                  leading: const Icon(Icons.key_outlined),
                  title: const Text('Permisos'),
                  onTap: () {
                    Navigator.of(context)
                        .push(RouteAnimation.animatedTransition(Permissions()));
                  },
                ),
              );
              menu.add(
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Configuración'),
                  onTap: () {
                    Navigator.of(context)
                        .push(RouteAnimation.animatedTransition(Settings()));
                  },
                ),
              );
              menu.add(
                ListTile(
                  leading: const Icon(Icons.colorize),
                  title: const Text('Colores'),
                  onTap: () {
                    Navigator.of(context)
                        .push(RouteAnimation.animatedTransition(DemoColors()));
                  },
                ),
              );
              menu.add(
                ListTile(
                  leading: const Icon(Icons.keyboard_arrow_left),
                  title: const Text('Inicio'),
                  onTap: () {
                    Navigator.of(context)
                        .push(RouteAnimation.animatedTransition(LoginScreen()));
                  },
                ),
              );
            } else {
              menu.add(
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Configuración'),
                  onTap: () {
                    Navigator.of(context)
                        .push(RouteAnimation.animatedTransition(Settings()));
                  },
                ),
              );
              menu.add(
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context)
                        .push(RouteAnimation.animatedTransition(Home()));
                  },
                ),
              );
              menu.add(
                ListTile(
                  leading: const Icon(Icons.keyboard_arrow_left),
                  title: const Text('Inicio'),
                  onTap: () {
                    Navigator.of(context)
                        .push(RouteAnimation.animatedTransition(LoginScreen()));
                  },
                ),
              );
            }

            return ListView(
              padding: EdgeInsets.zero,
              children: menu,
            );
          }
        ),
    );
  }
}


/*class MyWidget extends StatelessWidget {
  @override
  Widget build(context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return FutureBuilder<String>(
      future: authService.readToken(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text('');
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
}*/
