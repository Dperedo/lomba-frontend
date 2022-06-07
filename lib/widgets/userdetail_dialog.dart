import 'package:flutter/material.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class UserDetailDialog extends StatelessWidget {
  const UserDetailDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 450.0,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).getPrimaryColor(),
                  image: DecorationImage(
                      image: NetworkImage(''), fit: BoxFit.cover)),
              child: Container(
                width: double.infinity,
                height: 170,
                child: Container(
                  alignment: Alignment(0.0, 2.5),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/hatori.jpg'),
                    backgroundColor:
                        Provider.of<ThemeProvider>(context).getPrimaryColor(),
                    radius: 60.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Diego Peredo",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nombre de usuario: ",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "dperedo",
                style: TextStyle(
                    fontSize: 15.0,
                    color:
                        Provider.of<ThemeProvider>(context).getIndicatorColor(),
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Correo: ",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "dperedo@gmail.com",
                style: TextStyle(
                  fontSize: 15.0,
                  color:
                      Provider.of<ThemeProvider>(context).getIndicatorColor(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Organización: ",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lomba, Dellorto",
                style: TextStyle(
                  fontSize: 15.0,
                  color:
                      Provider.of<ThemeProvider>(context).getIndicatorColor(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
