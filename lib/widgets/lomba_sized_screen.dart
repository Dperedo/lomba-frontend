import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/preferences.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_appmenu.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key, required this.title, required this.principal}) : super(key: key);

  final Widget principal;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LombaAppBar(title: title),
      body: principal,
      drawer: const LombaSideMenu(),
    );
  }
}

class BigScreen extends StatelessWidget {
  BigScreen({Key? key, required this.title, required this.principal}) : super(key: key);

  final Widget principal;
  final String title;
  final double leftPre = Preferences.paddingLeft.toDouble();
  final double rightPre = Preferences.paddingRight.toDouble();

  @override
  Widget build(BuildContext context) {
    //final int leftPre = Preferences.paddingLeft;
    //final double rightPre = Preferences.paddingRight.toDouble();
    return Padding(
      padding: EdgeInsets.only(left: leftPre,right: rightPre),
      child: Row(
        children: [
          const SizedBox(
            width: 300,
            child: LombaAppMenu(),
          ),
          Expanded(
            child: Scaffold(
              appBar: LombaAppBar(title: title),
              body: principal,
            ),
          ),
        ],
      ),
    );
  }
}
