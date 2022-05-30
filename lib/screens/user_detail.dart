import 'package:flutter/material.dart';

//import 'package:front_lomba/model/models.dart';

class UserDetailSection extends StatelessWidget {
  const UserDetailSection({
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
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage(''), fit: BoxFit.cover)),
              child: Container(
                width: double.infinity,
                height: 170,
                child: Container(
                  alignment: Alignment(0.0, 2.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80'),
                    backgroundColor: Colors.blue,
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
                  style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nombre de usuario: ",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue[700],
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "dperedo",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  letterSpacing: 2.0,
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
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue[700],
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "dperedo@gmail.com",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Organización: ",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blue[700],
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lomba, Dellorto",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
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
