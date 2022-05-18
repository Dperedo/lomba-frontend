import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {

  final String title;
  final String subtitle;
  
  const TitleSection({
    Key? key, 
    required this.title,
    required this.subtitle
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(28.0),
      child: Column(
        children: [
          Align(alignment: Alignment.centerLeft, child: new Text(this.title)),
          SizedBox(
            height: 18,
          ),
          Align(alignment: Alignment.centerLeft, child: new Text(this.subtitle)),
        ],
      ),
    );
  }
}