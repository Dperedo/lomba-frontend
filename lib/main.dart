import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/router/app_routes.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  
  const MyApp({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      //initialRoute: AppRoutes.initialRoute,
      initialRoute: '/organizaciones',
      //routes: AppRoutes.getAppRoutes(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => const Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/organizaciones': (context) => const Organization(),
        '/usuarios': (context) => const User(),
      },
      //onGenerateRoute: AppRoutes.onGenerateRoute,
      //theme: AppTheme.lightTheme
    );
  }
}