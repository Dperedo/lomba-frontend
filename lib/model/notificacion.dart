import 'package:flutter/material.dart';

//import 'package:front_lomba/model/models.dart';

class NotificacionSection extends StatelessWidget {

  
  const NotificacionSection({
    Key? key, 
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Banner(
          message: 'New Arrival',
          location: BannerLocation.bottomStart,
          child: Container(
            height: 200,
            width: 200,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: const Text('Some Item'),
          ),
        ),
      )
    );
    /*return Scaffold(
      appBar: AppBar(title: Text('Banners'),),
      body: MaterialBanner(
        content: const Text('Error message text'),
        leading: CircleAvatar(child: Icon(Icons.delete)),
        actions: [
          /*FlatButton(
            child: const Text('ACTION 1'),
            onPressed: () { },
          ),
          FlatButton(
            child: const Text('ACTION 2'),
            onPressed: () { },
          ),*/
        ],
      ),
    );*/
  }
}