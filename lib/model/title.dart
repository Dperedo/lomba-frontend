import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleSection({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(28.0),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: new Text(
                this.title,
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.7),
              )),
          SizedBox(
            height: 12,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: new Text(
                this.subtitle,
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.2),
              )),
        ],
      ),
    );
  }
}
