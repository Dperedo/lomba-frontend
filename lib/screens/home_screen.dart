import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/screens/login_screen.dart';
import 'package:front_lomba/styles/styles.dart';

//void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const appTitle = 'Menu';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      body: Text('Lomba!',style: Theme.of(context).textTheme.headline3,),
      
      backgroundColor: Styles.defaultGreengroundColor,
      drawer: DrawerSection(),
    );
  }
}